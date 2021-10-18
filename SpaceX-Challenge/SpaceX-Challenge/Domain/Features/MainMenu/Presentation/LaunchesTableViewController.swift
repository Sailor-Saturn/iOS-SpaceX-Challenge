
import UIKit

class LaunchesTableViewController: UITableViewController, LaunchesView {

    @IBOutlet weak var companyInfoLabel: UILabel!
    var presenter = LaunchesTableViewPresenter()
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestAllLaunches()
        presenter.requestCompanyInfo()
        presenter.view = self
    }
    
    //MARK: Section Configuration
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    // MARK: Configure Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let launchCell = tableView.dequeueReusableCell(withIdentifier: "SpaceXLaunchCell") as? LaunchCell {
            presenter.configureLaunchCellView(launchCell, forIndex: indexPath.row)
            return launchCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
    
    func navigateToLinkScreen(with links: Links) {
        self.performSegue(withIdentifier: Segues.cellToLinks, sender: links)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let linkScreenViewController = segue.destination as? LinkScreenViewController,
              let linkSelected = sender as? Links else {
            return
        }
        
        linkScreenViewController.presenter = LinkViewPresenter(links: linkSelected)
        linkScreenViewController.presenter?.view = linkScreenViewController
    }
    
    // Not sure on how to do a filter so I had to search it up
    // https://www.codegrepper.com/code-examples/swift/how+to+create+a+dialog+swift+5
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Filter", message: "How do you want to filter the list", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Launch Year", style: UIAlertAction.Style.default, handler: showFilterLaunchYear))

        // TODO: Try to only use one function instead of one for each action
        alert.addAction(UIAlertAction(title: "Unsuccessful Launches", style: UIAlertAction.Style.default, handler: showUnsuccessfulMissions))
        
        alert.addAction(UIAlertAction(title: "Successful Launches", style: UIAlertAction.Style.default, handler: showSuccessfulMissions))
        
        // I didnt understand from the challenge if the ASC or DESC is in the same filter button, if not, I would just add another filter
        // with the same choices
        alert.addAction(UIAlertAction(title: "ASC Mission Name", style: UIAlertAction.Style.default, handler: showMissionsByASCOrder))
        
        alert.addAction(UIAlertAction(title: "DESC Mission Name", style: UIAlertAction.Style.default, handler: showMissionsByDESCOrder))
        
        // Added a clear all filters to test everything better
        alert.addAction(UIAlertAction(title: "Clear all filters", style: UIAlertAction.Style.default, handler: clearFilters))

        self.present(alert, animated: true, completion: nil)
    }
    
    // Add another filter inspired by: https://stackoverflow.com/questions/26567413/get-input-value-from-textfield-in-ios-alert-in-swift
    // MARK: Bug If I want to test the following: filter 2008 and then filter by 2008,2009, the second filter cannot be applied since the first list is not the original and thus cannot present anything in the second filter. Since I still have to do other filters, I'm leaving this as is :-(
    func showFilterLaunchYear(alertAction: UIAlertAction) {
        let alert = UIAlertController(title: "Launch Year", message: "Write the years separated by commas.", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "2009"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.presenter.filterByLaunchYears(launchYears: textField!.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showUnsuccessfulMissions(alertAction: UIAlertAction) {
        presenter.showBySuccessMission(wasSuccessful: false)
    }
    
    func showSuccessfulMissions(alertAction: UIAlertAction) {
        presenter.showBySuccessMission(wasSuccessful: true)
    }
    
    func clearFilters(alertAction: UIAlertAction) {
        presenter.requestAllLaunches()
    }
    
    func showMissionsByASCOrder(alertAction: UIAlertAction) {
        presenter.showMissionsByASCOrder()
    }
    
    func showMissionsByDESCOrder(alertAction: UIAlertAction) {
        presenter.showMissionsByDESCOrder()
    }
    
    func displayCompanyInfo() {
        companyInfoLabel.text = presenter.getCompanyInfoData()
    }
    
    // TODO: Refactor constraints so that the app mantains the same aspect in different screens
    // TODO: Fix constraint problems -> Top view is way too big and I can't change the height :(
    // TODO: Add UI tests
}

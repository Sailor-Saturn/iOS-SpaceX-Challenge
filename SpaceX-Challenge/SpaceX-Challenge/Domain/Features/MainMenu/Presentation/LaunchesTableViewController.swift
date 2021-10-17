
import UIKit

class LaunchesTableViewController: UITableViewController, LaunchesView {

    var presenter = LaunchesTableViewPresenter()
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestAllLaunches()
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
    
}

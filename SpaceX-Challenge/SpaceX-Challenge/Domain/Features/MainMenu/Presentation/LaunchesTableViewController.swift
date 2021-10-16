
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
}

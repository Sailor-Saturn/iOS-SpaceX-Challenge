
import UIKit

class LaunchesTableViewController: UITableViewController {
    let presenter = LaunchesTableViewPresenter()
    
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
        
        if let sandwichCell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell") as? LaunchCell {
            presenter.configureMenuSandwichView(sandwichCell, forIndex: indexPath.row)
            return sandwichCell
        }
        
        return UITableViewCell()
    }
    
}

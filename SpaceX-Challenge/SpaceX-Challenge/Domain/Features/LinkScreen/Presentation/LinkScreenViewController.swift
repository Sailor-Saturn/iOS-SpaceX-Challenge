
import UIKit

class LinkScreenViewController: UITableViewController, LinksView{
    var presenter: LinkViewPresenter?
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.presenter?.viewDidLoad()
    }
    
    //MARK: Section Configuration
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let nSections = presenter?.numberOfSections() else {
            return 1
        }
        return nSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = presenter?.titleForSection() else {
            return "Links"
        }
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRowsInSection() else {
            return 3 //article, wikipedia, yt
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let linkCell = tableView.dequeueReusableCell(withIdentifier: "SpaceXLinkCell") as? LinkCell {
            presenter?.configureLinkCell(linkCell, forIndex: indexPath.row)
            return linkCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelect(row: indexPath.row)
    }
}

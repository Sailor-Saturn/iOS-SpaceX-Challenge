
import UIKit

class LinkScreenViewController: UIViewController, LinksView {
    var presenter: LinkViewPresenter?
    
    @IBOutlet weak var articleLabel: UILabel!
    
    @IBOutlet weak var wikipideaLabel: UILabel!
    
    @IBOutlet weak var videoLabel: UILabel!
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    func displayLinks() {
        articleLabel.text  = presenter?.getArticleLink()
        wikipideaLabel.text = presenter?.getWikipideaLink()
        videoLabel.text = presenter?.getVideoLink()
    }
}

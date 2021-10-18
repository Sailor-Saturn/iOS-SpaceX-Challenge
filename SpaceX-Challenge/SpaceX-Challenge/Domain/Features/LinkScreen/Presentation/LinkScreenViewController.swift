
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
        
        if let url = URL(string: articleLabel.text ?? "https://www.hackingwithswift.com/example-code/system/how-to-open-a-url-in-safari") {
            UIApplication.shared.open(url)
        }
    }
    
    func displayLinks() {
        articleLabel.text  = presenter?.getArticleLink()
        wikipideaLabel.text = presenter?.getWikipideaLink()
        videoLabel.text = presenter?.getVideoLink()
    }
}

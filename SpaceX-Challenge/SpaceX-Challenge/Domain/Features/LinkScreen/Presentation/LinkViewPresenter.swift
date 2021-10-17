
import Foundation

public protocol LinksView {
    func displayLinks()
}

public class LinkViewPresenter {
    weak var view: LinkScreenViewController?
    let links: Links
    
    init(links: Links) {
        self.links = links
    }
    
    func viewDidLoad() {
        view?.displayLinks()
    }
    
    func getArticleLink() -> String {
        return "No article"
    }
    
    func getWikipideaLink() -> String {
        return "No wikipidea link"
    }
    
    func getVideoLink() -> String {
        return "no video"
    }
}

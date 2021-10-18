
import Foundation

public protocol LinksView {
    func displayLinks()
}

public class LinkViewPresenter {
    let manager: LinkManager
    weak var view: LinkScreenViewController?
    let links: Links
    
    init(links: Links) {
        self.links = links
        self.manager = LinkManager()
    }
    
    func viewDidLoad() {
        view?.displayLinks()
    }
    
    func getArticleLink() -> String {
        return manager.getLink(with: links.article)
    }
    
    func getWikipideaLink() -> String {
        return "No wikipidea link"
    }
    
    func getVideoLink() -> String {
        return "no video"
    }
}

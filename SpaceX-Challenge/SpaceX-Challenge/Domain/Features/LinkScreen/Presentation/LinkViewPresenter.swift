
import Foundation
import UIKit
public protocol LinksView {
}

public class LinkViewPresenter {
    let manager: LinkManager
    public var view: LinksView?
    let links: Links
    
    let validLinks: [String:String]
    
    init(links: Links) {
        self.links = links
        self.manager = LinkManager()
        
        validLinks = manager.getValidLinks(links: self.links)
    }
    
//    func viewDidLoad() {
//        view?.displayLinks()
//    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func titleForSection() -> String {
        return "Links"
    }
    
    func numberOfRowsInSection() -> Int {
        return validLinks.count
    }
    
    //MARK: Cell Configuration
    func configureLinkCell(_ view: LinkCellView, forIndex index: Int){
        // Weird approach but since I used a dictionary I needed to use this
        // Used this approach from stack over flow: https://stackoverflow.com/questions/24640990/how-do-i-get-the-key-at-a-specific-index-from-a-dictionary-in-swift
        let link = Array(validLinks.keys)[index]
        view.displayLinkCell(with: link)
    }
    
    func didSelect(row: Int) {
        let link = Array(validLinks.values)[row]
        
        // Didn't know how to do this before so I had to look it up
        // https://www.hackingwithswift.com/example-code/system/how-to-open-a-url-in-safari
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}


import Foundation

public class LinkManager {
    func getLink(with urlOptional: String?) -> String {
        guard let url = urlOptional else {
            return "No link available."
        }
        
        return url
    }
    
    func checkIfLinkIsValid(link: String? ) -> String {
        guard let linkValid = link else {
            return ""
        }
        return linkValid
    }
    
    // I just want to show the valid/existing links, I'm doing something very ineffective :(
    func getValidLinks(links: Links) -> [String:String] {
        var linksDictionary: [String:String] = [:]
        var link = checkIfLinkIsValid(link: links.article)
        
        if link != "" {
            linksDictionary["article"] = link
        }
        
        link = checkIfLinkIsValid(link: links.wikipedia)
        
        if link != "" {
            linksDictionary["wikipedia"] = checkIfLinkIsValid(link: link)
        }
        
        link = checkIfLinkIsValid(link: links.videoPages)
        
        if link != "" {
            linksDictionary["youtube"] = checkIfLinkIsValid(link: link)
        }
        
        return linksDictionary
    }
}

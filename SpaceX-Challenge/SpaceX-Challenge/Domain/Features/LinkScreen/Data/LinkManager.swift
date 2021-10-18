
import Foundation

public class LinkManager {
    func getLink(with urlOptional: String?) -> String {
        guard let url = urlOptional else {
            return "No link available."
        }
        
        return url
    }
}

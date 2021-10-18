
import Foundation
import UIKit

class LinkCell: UITableViewCell, LinkCellView {
    
    @IBOutlet weak var linkCell: UILabel!
    
    func displayLinkCell(with text: String) {
        linkCell.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

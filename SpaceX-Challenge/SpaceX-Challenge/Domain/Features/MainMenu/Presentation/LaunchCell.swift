
import Foundation
import UIKit

class LaunchCell: UITableViewCell, LaunchView {
    @IBOutlet weak var missionNameLabel: UILabel!
 
    func displayMissionName(with text: String){
        missionNameLabel.text = text
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

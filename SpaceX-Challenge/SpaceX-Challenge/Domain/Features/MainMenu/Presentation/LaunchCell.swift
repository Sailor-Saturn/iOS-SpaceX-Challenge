
import Foundation
import UIKit

class LaunchCell: UITableViewCell, LaunchView {
    @IBOutlet weak var missionNameLabel: UILabel!
 
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    @IBOutlet weak var daysFromLabel: UILabel!
    
    @IBOutlet weak var wasSuccessfulButton: UIButton!
    
    func displayMissionName(with text: String){
        missionNameLabel.text = "Mission: " + text
    }
    
    func displayDateTimeLabel(with date: String) {
        dateTimeLabel.text = "Date/Time: " + date
    }
    
    func displayRocketNameLabel(with text: String) {
        rocketNameLabel.text = "Rocket Name/Type: " + text
    }
    
    func displayDaysFromLabel(with text: String) {
        daysFromLabel.text = text
    }
    
    // Very basic but I keep forgetting :(
    // https://stackoverflow.com/questions/26837371/how-to-change-uibutton-image-in-swift/26837428
    func displayWasMissionSuccessful(with successFlag: Bool) {
        var image: UIImage?
        var color: UIColor
        if (successFlag) {
            image = UIImage(systemName: "checkmark")
            color = .green
        }else {
            image = UIImage(systemName: "xmark")
            color = .red
            
        }
        
        wasSuccessfulButton.setImage(image, for: .normal)
        wasSuccessfulButton.tintColor = color
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

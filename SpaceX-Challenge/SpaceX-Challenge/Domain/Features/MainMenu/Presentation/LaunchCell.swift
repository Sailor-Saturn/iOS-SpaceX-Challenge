
import Foundation
import UIKit

class LaunchCell: UITableViewCell, LaunchView {
    @IBOutlet weak var missionNameLabel: UILabel!
 
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    @IBOutlet weak var daysFromLabel: UILabel!
    
    @IBOutlet weak var wasSuccessfulButton: UIButton!
    
    @IBOutlet weak var patchImage: UIImageView!
    
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
    
    // I didnt know how to show image from URL so I needed to research online and found this
    // https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
    // I still dont understand the dispatch queue behaviour but this
    func displayPatchImage(with urlString: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let url = urlString else {
                return
            }
            
            guard let newURL = URL(string: url) else {
                return
            }
            
            guard let imageData = try? Data(contentsOf: newURL) else {
                return
            }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.patchImage.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        patchImage.image = nil
    }
}


import Foundation

public protocol LaunchesView: class {
    func reloadData()
}
public class LaunchesTableViewPresenter {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func titleForSection() -> String {
        return "Launches"
    }
    
    func numberOfRowsInSection() -> Int {
        return 10 // TODO: Change when connecting to manager
    }
}

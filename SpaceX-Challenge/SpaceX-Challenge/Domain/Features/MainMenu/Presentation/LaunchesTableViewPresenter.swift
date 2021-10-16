
import Foundation

public protocol LaunchesView {
    func reloadData()
    
}
public class LaunchesTableViewPresenter {
    //let launchesManager = LaunchesManager()
    
    let gateway = AllLaunchesGateway()
    
    public var view: LaunchesView?
    
    var allLaunches = [AllLaunches]() {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func titleForSection() -> String {
        return "Launches"
    }
    
    func numberOfRowsInSection() -> Int {
        print(allLaunches.count)
        return allLaunches.count // TODO: Change when connecting to manager
    }
    
    //MARK: Cell Configuration
    func configureLaunchCellView(_ view: LaunchView, forIndex index: Int){
        let launch = allLaunches[index]
        view.displayMissionName(with: launch.mission_name)
    }
    
    func requestAllLaunches() {
        gateway.getAllLaunches { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let launches):
                self?.allLaunches = launches
            }
        }
    }
}

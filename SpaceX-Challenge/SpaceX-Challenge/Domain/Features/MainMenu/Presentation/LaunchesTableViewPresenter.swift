
import Foundation

public protocol LaunchesView {
    func reloadData()
    
}
public class LaunchesTableViewPresenter {
    
    let gateway = AllLaunchesGateway()
    let launchManager = LaunchesManager()
    
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
        return allLaunches.count
    }
    
    //MARK: Cell Configuration
    func configureLaunchCellView(_ view: LaunchView, forIndex index: Int){
        let launch = allLaunches[index]
        view.displayMissionName(with: launch.mission_name)
        
        view.displayDateTimeLabel(with: launchManager.populateDate(with: launch.launch_date_utc))
        
        view.displayRocketNameLabel(with: launchManager.populateRocketName(with: launch.rocket))
        
        view.displayDaysFromLabel(with: launchManager.populateDateFromToday(with: launch.launch_date_utc))
        
        view.displayWasMissionSuccessful(with: launch.launch_success ?? false)
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

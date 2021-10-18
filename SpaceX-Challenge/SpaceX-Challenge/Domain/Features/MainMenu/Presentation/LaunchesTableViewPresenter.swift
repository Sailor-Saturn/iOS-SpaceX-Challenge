
import Foundation

public protocol LaunchesView {
    func reloadData()
    func navigateToLinkScreen(with links: Links)
    func displayCompanyInfo()
}
public class LaunchesTableViewPresenter {
    
    let allLaunchesGateway = AllLaunchesGateway()
    let companyInfoGateway = CompanyInfoGateway()
    let launchManager = LaunchesManager()
    
    public var view: LaunchesView?
    
    var allLaunches = [Launch]() {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
    var companyInfo: Info?{
        didSet {
            DispatchQueue.main.async {
                self.view?.displayCompanyInfo()
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
        
        view.displayPatchImage(with: launch.links?.imagePatch)
    }
    
    func requestAllLaunches() {
        allLaunchesGateway.getAllLaunches { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let launches):
                self?.allLaunches = launches
            }
        }
    }
    
    func requestCompanyInfo() {
        companyInfoGateway.getAllLaunches {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let info):
                self?.companyInfo = info
            }
        }
    }
    
    func didSelect(row: Int) {
        let selectedLaunch = allLaunches[row]
        guard let links = selectedLaunch.links else {
            return
        }
        view?.navigateToLinkScreen(with: links)
    }
    
    func filterByLaunchYears(launchYears: String) {
        // Awful approach to get the original list but I didnt have time to think of a new approach
        if(launchYears == "") {
            requestAllLaunches()
        }else {
            allLaunches = launchManager.filterByLaunchYears(launchYears: launchYears, launches: allLaunches)
        }
        
    }
    
    func showBySuccessMission(wasSuccessful flag: Bool) {
        allLaunches = launchManager.showBySuccessMission(wasSuccessful: flag, launches: allLaunches)
    }
    
    func showMissionsByASCOrder(){
        allLaunches = launchManager.showMissionsByASCOrder(launches: allLaunches)
    }
    
    func showMissionsByDESCOrder(){
        allLaunches = launchManager.showMissionsByDESCOrder(launches: allLaunches)
    }
    
    func getCompanyInfoData() -> String {
        guard let info = companyInfo else {
            return "No information about the company available... Please wait. "
        }
        return launchManager.getCompanyInfoData(with: info)
    }
}

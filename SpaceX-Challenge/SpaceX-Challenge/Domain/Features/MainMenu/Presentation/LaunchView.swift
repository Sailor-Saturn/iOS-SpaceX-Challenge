import Foundation

public protocol LaunchView {
    func displayMissionName(with text: String)
    func displayDateTimeLabel(with date: String)
    func displayRocketNameLabel(with text: String)
    func displayDaysFromLabel(with text: String)
    func displayWasMissionSuccessful(with successFlag: Bool)
}

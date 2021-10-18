

import Foundation

public class LaunchesManager {

    // TODO: Add all Gateway request must be passed through the manager
    // TODO: Date format tests
    
    func convertDateFromUTCFormat(date: String?) -> Date? {
        guard let dateValue = date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: dateValue)
    }
    
    // yet another date conversion, not the best approach for sure
    func getYearOfLaunchDate(date: String?) -> String {
        guard let dateValue = date else {
            return " " // default
        }
        let getDateUTC = convertDateFromUTCFormat(date: dateValue)
        
        guard let newDate = getDateUTC else {
            return " "
        }
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy"
        dateFormatter.timeZone = NSTimeZone.local

        return dateFormatter.string(from: newDate)
    }
    
    func convertDateToDesiredFormat(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM, d yyyy 'at' h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        
        return dateFormatter.string(from: date!)
    }
    
    // Date formatter used from this link: https://stackoverflow.com/questions/29392874/converting-utc-date-format-to-local-nsdate
    // Essentially I needed to get the utc format and convert into the desired format
    func populateDate(with date: String?) -> String {
        guard let dateValue = date else {
            return "No date available"
        }
        
        let dateUTCFormat = convertDateFromUTCFormat(date: dateValue)

        
        return convertDateToDesiredFormat(date: dateUTCFormat)
    }
    
    // This populate looks terrible but due to lack of time I tried to create combinations between optional values
    func populateRocketName(with rocket: Rocket?) -> String {
        var rocketNameValue = ""
        
        guard let rocketValue = rocket else {
            return "No rocket/ No type"
        }
        
        guard let rocketName = rocketValue.name else {
            rocketNameValue = "No rocket"
            
            guard let rocketType = rocketValue.type else {
                return rocketNameValue + "/ No type"
            }
            
            return rocketNameValue + "/" + rocketType
        }
        
        guard let rocketType = rocketValue.type else {
            return rocketName + "/ No type"
        }
        
        return rocketName + "/" + rocketType
        
    }
    
    // Not copy pasted but relied on this explanation from stack over flow https://stackoverflow.com/questions/26807416/check-if-date-is-before-current-date-swift
    // TODO: Test when the day is in the future, present and past.
    func populateDateFromToday(with date: String?) -> String {
        let todaysDate = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        guard let dateValue = date else {
            return "No date available"
        }
        
        // Check if date is earlier than the current date
        guard let dateLaunchUTC = convertDateFromUTCFormat(date: dateValue) else {
            return "Error"
        }
        
        if(dateLaunchUTC < todaysDate) {
            return "Days since: " + calendar.numberOfDaysBetween(dateLaunchUTC, and: todaysDate) + " days"
        }else if (dateLaunchUTC == todaysDate) {
            return "The launch is today! 🥳" // Small easter egg
        }
        return "Days from now: " + calendar.numberOfDaysBetween(todaysDate, and: dateLaunchUTC) + " days"
    }
    
    func filterByLaunchYears(launchYears: String, launches: [Launch]) -> [Launch] {
        let launchYearsArray: [String]
        // Used this approach to slice the launch years: https://stackoverflow.com/questions/25678373/split-a-string-into-an-array-in-swift
        launchYearsArray = launchYears.components(separatedBy: ", ")
        return launches.filter{launchYearsArray.contains(getYearOfLaunchDate(date: $0.launch_date_utc))}
    }
    
    func showBySuccessMission(wasSuccessful flag: Bool, launches: [Launch]) -> [Launch]{
        return launches.filter{flag == $0.launch_success}
    }
    
    // Didnt know how to filter by name so I searched for this: https://stackoverflow.com/questions/26719744/swift-sort-array-of-objects-alphabetically
    func showMissionsByASCOrder(launches: [Launch]) -> [Launch] {
        return launches.sorted { $0.mission_name.lowercased() < $1.mission_name.lowercased() }
    }
    
    func showMissionsByDESCOrder(launches: [Launch]) -> [Launch] {
        return launches.sorted { $0.mission_name.lowercased() > $1.mission_name.lowercased() }
    }
    
    func getCompanyInfoData(with info: Info) -> String{
        return "\(info.name) was founded by \(info.founder) in \(info.founded). It has now \(info.employees) employees, \(info.launch_sites) launch sites, and is valued at USD \(info.valuation)"
    }
}

// This day calculator was referenced from this tutorial: https://sarunw.com/posts/getting-number-of-days-between-two-dates/
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> String {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return "\(numberOfDays.day! + 1)"
    }
}

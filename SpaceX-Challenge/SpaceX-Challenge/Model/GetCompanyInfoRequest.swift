import Foundation

struct GetCompanyInfoRequest: URLRequestable {
    let url: URL
    
    init() {
        let urlString = "https://api.spacexdata.com/v3/info"
        guard let url = URL(string: urlString) else { fatalError() }
        self.url = url
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

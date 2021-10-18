
import Foundation

enum CompanyInfoGatewayError: Error {
    case errorGettingData
    case errorParsingData
    case operationFailed
}

protocol CompanyInfoGatewayProtocol: AnyObject {
    func getAllLaunches(completion: @escaping(Result<Info, CompanyInfoGatewayError>) -> Void)
}

final class CompanyInfoGateway: CompanyInfoGatewayProtocol {
    let networkSession: NetworkSession

    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let decoder = JSONDecoder()
    
    func getAllLaunches(completion: @escaping (Result<Info, CompanyInfoGatewayError>) -> Void) {
        
        let request = GetCompanyInfoRequest()
        
        networkSession.loadData(from: request.urlRequest) { data, _ in
            guard let jsonData =  data else {
                completion(.failure(.errorGettingData))
                return
            }
            
            do {
                let response = try self.decoder.decode(Info.self, from: jsonData)
                completion(.success(response))
            } catch {
                debugPrint(error)
                print(error.localizedDescription)
                completion(.failure(.errorParsingData))
            }
        }
    }
    
    
}

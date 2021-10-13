//
//  AllLaunchesGateway.swift
//  SpaceX-Challenge

import Foundation

enum AllLaunchesGatewayError: Error {
    case errorGettingData
    case errorParsingData
    case operationFailed
}

protocol AllLaunchesGatewayProtocol: AnyObject {
    func getAllLaunches(completion: @escaping(Result<[AllLaunches], AllLaunchesGatewayError>) -> Void)
}

final class AllLaunchesGateway: AllLaunchesGatewayProtocol {
    let networkSession: NetworkSession

    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let decoder = JSONDecoder()
    
    func getAllLaunches(completion: @escaping (Result<[AllLaunches], AllLaunchesGatewayError>) -> Void) {
        
        let request = GetAllLaunchesRequest()
        
        networkSession.loadData(from: request.urlRequest) { data, _ in
            guard let jsonData =  data else {
                completion(.failure(.errorGettingData))
                return
            }
            
            do {
                let response = try self.decoder.decode([AllLaunches].self, from: jsonData)
                completion(.success(response))
            } catch {
                
                completion(.failure(.errorParsingData))
            }
        }
    }
    
    
}

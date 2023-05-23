//
//  ARNewtworkManager.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable>(url: URL, completion: ((T?, Error? ) -> Void)?)
}

struct ARNetworkManager {
    private var httpMethod: String
    private var param: [String: Any]?
    init(httpMethod: HTTPMethod = .GET, param: [String: Any] = [String: Any]()) {
        self.httpMethod = httpMethod.rawValue
        self.param = param
    }
    
    private func createRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.networkServiceType = .default
        request.cachePolicy = .reloadRevalidatingCacheData
        request.timeoutInterval = 100
        request.httpShouldHandleCookies = true
        request.httpShouldUsePipelining = false
        request.allowsCellularAccess = true
        addParams(&request)
        return request
    }
}

// Quert parameter and additional parameters
extension ARNetworkManager {
    private func addParams(_ request: inout URLRequest) {
        switch HTTPMethod(rawValue: httpMethod) {
        case .GET:
            if let param = param {
                if var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) {
                    let queryItems = param.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                    urlComponents.queryItems = queryItems
                    if let finalURL = urlComponents.url {
                        request.url = finalURL
                    }
                }
            }
        case .POST:
            if let param = param, param.keys.count > 0 {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        case .none:
            break
        }
    }
}

// MARK: - Network call

extension ARNetworkManager: NetworkManagerProtocol {
    func executeRequest<T: Decodable>(url: URL, completion: ((T?, Error? ) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: self.createRequest(url), completionHandler: { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? jsonDecoder.decode(T.self, from: data) {
                completion?(decodedResponse, nil)
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        })
        dataTask.resume()
    }
}

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    return decoder
}()

//
//  ARUserViewModel.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 20/05/23.
//

import Foundation

typealias ResultsCompletionClosure = ((Results?, Error?) -> Void)

protocol UserViewModelProtocol {
    func callUsersAPI(page: Int, completion: @escaping ResultsCompletionClosure)
}

class UserListViewModel: NSObject, UserViewModelProtocol {
    
    func callUsersAPI(page: Int, completion: @escaping ResultsCompletionClosure) {
        guard let baseURL = ARAPI.baseURL,
              let url =  URL(string: baseURL) else {
            completion(nil, ARNetworkError.invalidUrl)
            return
        }
        let params = ["page":String(page), "results":"10"]
        ARNetworkManager.init(param: params).executeRequest(url: url, completion: completion)
    }
}

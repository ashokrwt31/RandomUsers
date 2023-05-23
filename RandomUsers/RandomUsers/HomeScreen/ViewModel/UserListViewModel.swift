//
//  ARUserViewModel.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

import Foundation

typealias ResultsCompletionClosure = ((Results?, Error?) -> Void)

protocol UserViewModelProtocol {
    func callUsersAPI(page: Int,perPageResult: Int, completion: @escaping ResultsCompletionClosure)
}

class UserListViewModel: NSObject, UserViewModelProtocol {
    
    func callUsersAPI(page: Int, perPageResult: Int, completion: @escaping ResultsCompletionClosure) {
        guard let baseURL = API.baseURL,
              let url =  URL(string: baseURL) else {
            completion(nil, NetworkError.invalidUrl)
            return
        }
        let params = ["page":String(page), "results":String(perPageResult)]
        ARNetworkManager.init(param: params).executeRequest(url: url, completion: completion)
    }
}

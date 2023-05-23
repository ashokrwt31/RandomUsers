//
//  ARWrapper.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

import Foundation

typealias UsersCompletionClosure = (([UserListModel]?) -> Void)

class UserListWrapper: NSObject {
    let indicator = ARActivityIndicator()
    private let userDetailDataStack: UserDetailDataStack
    
    @objc override init() {
        userDetailDataStack = UserDetailDataStack(mainContext: CoreDataManager.shared.mainContext)
        super.init()
    }
    
    @objc func getUser(page: Int, perPageResult: Int, completion: @escaping UsersCompletionClosure) {
        fetchLocalUserList { users in
            if let userList = users, userList.count > page * perPageResult {
                completion(users)
            } else { UserListViewModel().callUsersAPI(page: page, perPageResult: perPageResult) {  (results, error) in
                if (error == nil), let usersResults = results {
                    self.saveUsersDataIntoDB(usersResults: usersResults.results)
                    let userViewModel = usersResults.results.map { userInfo in
                        return UserListModel(
                            firstName: userInfo.name.first,
                            lastName: userInfo.name.last,
                            email: userInfo.email,
                            dateOfJoining: userInfo.registered.date,
                            dateOfBirth: userInfo.dob.date,
                            age: String(userInfo.dob.age),
                            largeImageURL: userInfo.picture.large,
                            mediumImageURL:userInfo.picture.medium,
                            thumbnailImageURL: userInfo.picture.thumbnail,
                            city: userInfo.location.city,
                            state: userInfo.location.state,
                            country: userInfo.location.country,
                            postcode: String(userInfo.location.postcode ?? "")
                        )
                    }
                    completion(userViewModel)
                } else {
                    completion([])
                }
            }
          }
        }
    }
    
    @objc func activityIndicator( view: UIView, isHidden: Bool) {
        userDetailDataStack.clearUsersDetail()
        if isHidden {
            indicator.hideIndicatorView()
        }
        else {
            indicator.startIndicatorView(uiView: view, style: .medium)
        }
    }
    
    @objc func getCountryFormatedText(_ text: String) -> NSString {
        return NSString(string: "country | \(text)")
    }
    
    @objc func getFormattedLoginStatus(dateString: String) -> NSString {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            return date.dateFormatterInString() as NSString
        } else {
            return "Invalid date format"
        }
    }
    
    @objc func getImage(from url: URL, on view: UIImageView, completion: @escaping (UIImage?) -> Void) {
        let indicator = ARActivityIndicator()
        indicator.startIndicatorView(uiView: view, style: .medium)
        UIImage.loadImage(from: url) { image in
            guard let downloadImage = image else {
                completion(nil)
                return
            }
            indicator.hideIndicatorView()
            completion(downloadImage)
        }
    }
}

extension UserListWrapper {
    
    private func saveUsersDataIntoDB(usersResults: [User]) {
        userDetailDataStack.saveUsersDetails(usersResults)
    }
    
    private func fetchLocalUserList(_ completion: @escaping (_ userList: [UserListModel]?) -> Void) {
        var userViewModel: [UserListModel] = []
        let users = userDetailDataStack.fetchUsersDetails()
        for user in users {
            let viewModel = UserListModel()
            viewModel.name = user.name ?? ""
            viewModel.email = user.email ?? ""
            viewModel.postalcode = user.postalcode ?? ""
            viewModel.country = user.country ?? ""
            viewModel.age = user.age as NSString? ?? ""
            viewModel.state = user.state ?? ""
            viewModel.city = user.city ?? ""
            viewModel.thumbnailImageURL = user.thumbnailImageURL ?? ""
            viewModel.mediumImageURL = user.mediumImageURL ?? ""
            viewModel.largeImageURL = user.largeImageURL ?? ""
            viewModel.dob =  user.dob ?? ""
            viewModel.doj =  user.doj ?? ""
            userViewModel.append(viewModel)
        }
        completion(userViewModel)
    }
    
    func createUserDetailViewModel(_ model: UserListModel) -> UserDetailModel{
        return UserDetailModel(name: model.name, email: model.email, doj: model.doj, dob: model.dob, age: model.age as String, largeImageURL: model.largeImageURL, city: model.city, state: model.state, country: model.country, postalcode: model.postalcode)
    }
}


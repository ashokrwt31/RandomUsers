//
//  UserDetailDataStack.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation
import CoreData

class UserDetailDataStack {
    
    let mainContext: NSManagedObjectContext
    init(mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    func saveUsersDetails(_ userList: [User]) {
        for userData in userList {
            guard let entity = NSEntityDescription.entity(forEntityName: "UserDetail", in: mainContext) else {
                return
            }
            let user = UserDetail(entity: entity, insertInto: mainContext)
            user.name = userData.name.first + userData.name.last
            user.age = String(userData.dob.age)
            user.email = userData.email
            user.country = userData.location.country
            user.postalcode = String(describing: userData.location.postcode)
            user.city = userData.location.city
            user.state = userData.location.state
            user.dob = userData.dob.date
            user.doj = userData.registered.date
            user.mediumImageURL = userData.picture.medium
            user.largeImageURL = userData.picture.large
            user.thumbnailImageURL = userData.picture.thumbnail
            
            mainContext.insert(user)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func fetchUsersDetails() -> [UserDetail] {
        let fetchRequest: NSFetchRequest<UserDetail> = UserDetail.fetchRequest()
        do {
            return try mainContext.fetch(fetchRequest)
        } catch {
            // Handle fetch error
            return []
        }
    }
    
    func clearUsersDetail() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetail")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try mainContext.execute(deleteRequest)
            try mainContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func entityHaveDataInDB(_ entityName: String) -> Bool {
        return CoreDataManager.shared.entityHaveDataInDB(entityName)
    }
}

//
//  UserDetailViewModel.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation

struct UserDetailModel {
    let name: String
    let email: String
    let doj: String
    let dob: String
    let age: String
    let largeImageURL: String
    let city: String
    let state: String
    let country: String
    let postalcode: String
    
    var formattedDOJ: String {
        if let date = Date().dateFormatterOfMonthWithFullName(from: doj) {
            return date
        } else {
            return doj
        }
    }
    
    var formattedDOB: String {
        if let date = Date().dateFormatterOfMonthWithShortName(from: dob) {
            return date
        } else {
            return dob
        }
    }
}

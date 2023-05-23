//
//  Date+Extension.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation

extension Date {
    func dateFormatterOfMonthWithShortName(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "dd MMM yyyy"
            return monthFormatter.string(from: date)
        }
        return nil
    }
    
    func dateFormatterOfMonthWithFullName(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        if let date = dateFormatter.date(from: dateString) {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM d, yyyy"
            return monthFormatter.string(from: date)
        }
        return nil
    }
    
   func dateFormatterInString() -> String {
        let dateFormatter = DateFormatter()
        if Calendar.current.isDateInYesterday(self) {
            dateFormatter.dateFormat = "h:mm a"
            return "Yesterday at " + dateFormatter.string(from: self)
        } else if Calendar.current.isDate(self, inSameDayAs: Date()) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: self)
        }
    }
}

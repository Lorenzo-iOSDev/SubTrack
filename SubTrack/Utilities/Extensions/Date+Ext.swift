//
//  Date+Ext.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import Foundation

extension Date {
    
    //returns a date 18 years ago today
    var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    //returns a date 100 years ago today
    var oneHundredYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    }
    
    //converts date to string
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self)
        
        return (dateString)
    }
    
    //returns the start of the week the date is within
    func startOfWeek(using calendar: Calendar = Calendar(identifier: .iso8601)) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    //returns the day before the date
    func dayBefore() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    //returns the date 7 days in the future
    func nextWeek() -> Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    
    //returns the date 1 month in the future
    func nextMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    //returns the date 4 months in the future
    func nextQuarter() -> Date {
        return Calendar.current.date(byAdding: .month, value: 4, to: self)!
    }
    
    //returns the date 6 months in the future
    func nextHalfYear() -> Date {
        return Calendar.current.date(byAdding: .month, value: 6, to: self)!
    }
    
    //returns the date 1 year in the future
    func nextYear() -> Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)!
    }
}

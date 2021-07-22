//
//  Date+Ext.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self)
        
        return (dateString)
    }
    
    func nextWeek() -> Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    
    func nextMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    func nextQuarter() -> Date {
        return Calendar.current.date(byAdding: .month, value: 4, to: self)!
    }
    
    func nextHalfYear() -> Date {
        return Calendar.current.date(byAdding: .month, value: 6, to: self)!
    }
    
    func nextYear() -> Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)!
    }
}

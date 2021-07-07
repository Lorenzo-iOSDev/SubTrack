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
    
}

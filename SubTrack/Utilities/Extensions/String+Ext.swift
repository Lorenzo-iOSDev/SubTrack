//
//  String+Ext.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 1/09/21.
//

import Foundation

extension String {
    
    //Extension to check if string variable is empty and or is just empty spaces
    func isEmptyIncWhiteSpace() -> Bool {
        if !self.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
    }
}

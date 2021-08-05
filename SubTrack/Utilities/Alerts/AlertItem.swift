//
//  AlertItem.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/08/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                       message: Text("The form was incomplete. Please fill it out and try again"),
                                       dismissButton: .default(Text("OK")))
    
    static let invalidDateComponent = AlertItem(title: Text("Invalid Date Component"),
                                                message: Text("Date component data was invalid. Please contact developer."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidDouble = AlertItem(title: Text("Invalid Double"),
                                         message: Text("Invalid data inputted for price, please make sure price only contains\n the numbers 0-9 and '.'"),
                                         dismissButton: .default(Text("OK")))
    
    static let invalidRetrieval = AlertItem(title: Text("Unable to retrieve data"),
                                            message: Text("Unable to retrieve saved data. Please contact developer."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidSavedData = AlertItem(title: Text("Saved data is invalid"),
                                            message: Text("Saved data is invalid. Please contact developer."),
                                            dismissButton: .default(Text("OK")))
    
    static let unableToSave = AlertItem(title: Text("Could not save data"),
                                            message: Text("Unable to save data. Please contact developer."),
                                            dismissButton: .default(Text("OK")))
}

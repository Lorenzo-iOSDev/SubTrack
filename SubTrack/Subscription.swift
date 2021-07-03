//
//  Subscription.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import Foundation

struct Subscription: Identifiable {
    var id: Int
    
    let serviceName: String
    let paymentFrequency: String
    let serviceSymbol: String
    let price: Double
}

struct MockData {
    static let service1 = Subscription(id: 0001,
                                       serviceName: "Apple TV+",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "tv",
                                       price: 14.99)
    
    static let service2 = Subscription(id: 0002,
                                       serviceName: "Netflix",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "tv",
                                       price: 19.99)
    
    static let service3 = Subscription(id: 0003,
                                       serviceName: "Spotify",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "music.note",
                                       price: 10.99)
    
    static let service4 = Subscription(id: 0004,
                                       serviceName: "Minecraft Server",
                                       paymentFrequency: "Quarterly",
                                       serviceSymbol: "server.rack",
                                       price: 4.99)
    
    static let services = [service1, service2, service3, service4]
}

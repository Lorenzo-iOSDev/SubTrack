//
//  Subscription.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import Foundation

enum Upcoming: String {
    case Today = "Today"
    case Tomorrow = "Tomorrow"
    case ThisWeek = "This Week"
    case ThisMonth = "This Month"
}

enum Symbols: String, CaseIterable{
    case TV = "tv"
    case Music = "headphones"
    case Server = "server.rack"
    case Gaming = "gamecontroller"
    case Network = "network"
}

enum PaymentFrequency: String, CaseIterable {
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    case Quarterly = "Quarterly"
    case BiAnnually = "Bi-Annually"
    case Annually = "Annually"
}

struct Subscription: Identifiable, Codable{
    var id = UUID()
    
    let serviceName: String
    let paymentFrequency: String
    let serviceSymbol: String
    let price: Double
    let paymentDateString: String
    
    var paymentDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = dateFormatter.date(from: paymentDateString) else { return nil }
        
        return date
    }
    
    var upcomingClassifier: Upcoming? {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let paymentDate = paymentDate else { return nil } //return error alert
        
        let dateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: paymentDate)
        let currentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: currentDate)
        
        //print("Day:\(dateComponents.day!) Month: \(dateComponents.month!) Year: \(dateComponents.year!)")
        
        guard let dateCompsDay = dateComponents.day else { return nil } //return error alert
        guard let currentDateCompsDay = currentDateComponents.day else { return nil } //return error alert
        
        let differenceInDays = dateCompsDay - currentDateCompsDay
        
        guard let dateCompsMonth = dateComponents.month else { return nil } //return error alert
        guard let currentDateCompsMonth = currentDateComponents.month else { return nil } //return error alert
        
        let differenceInMonths = dateCompsMonth - currentDateCompsMonth
        
        //print("Difference in Days: \(differenceInDays), Months \(differenceInMonths)")
        
        if differenceInDays == 0 && differenceInMonths == 0 {
            return Upcoming.Today
        } else if differenceInDays == 1 && differenceInMonths == 0 {
            return Upcoming.Tomorrow
        } else if differenceInDays <= 7 && differenceInDays > 0 && differenceInMonths == 0 {
            return Upcoming.ThisWeek
        } else if differenceInDays > 7 && differenceInMonths == 0 {
            return Upcoming.ThisMonth
        }
        
        return nil
    }
    
    var sortPriority: Int {
        switch upcomingClassifier {
        case .Today:
            return 1
        case .Tomorrow:
            return 2
        case .ThisWeek:
            return 3
        case .ThisMonth:
            return 4
        case .none:
            return 5
        }
    }
}

struct MockData {
    static let service1 = Subscription(serviceName: "Apple TV+",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "tv",
                                       price: 14.99,
                                       paymentDateString: "09/07/2020")
    
    static let service2 = Subscription(serviceName: "Netflix",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "tv",
                                       price: 19.99,
                                       paymentDateString: "10/07/2019")
    
    static let service3 = Subscription(serviceName: "Spotify",
                                       paymentFrequency: "Monthly",
                                       serviceSymbol: "music.note",
                                       price: 10.99, paymentDateString: "06/07/2018")
    
    static let service4 = Subscription(serviceName: "Minecraft Server",
                                       paymentFrequency: "Quarterly",
                                       serviceSymbol: "server.rack",
                                       price: 4.99, paymentDateString: "23/07/2015")
    
    static let services = [service1, service2, service3, service4]
}

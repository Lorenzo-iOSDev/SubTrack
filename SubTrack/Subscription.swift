//
//  Subscription.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import Foundation

final class Subscription: Identifiable, Codable{
    
    var id = UUID()
    
    let serviceName: String
    let paymentFrequency: PaymentFrequency
    let serviceSymbol: Symbols
    let price: Double
    let subStartDate: Date
    
    var paymentDate: Date
    
    var paymentIsDue: Bool {
        let today = Date()
        
        if (paymentDate < today) {
            return true
        }
        
        return false
    }
    
    var firstPaymentDateSet: Bool = false
    
    var upcomingClassifier: Upcoming? {
        let calendar = Calendar.autoupdatingCurrent
        let currentDate = Date()
        
        let paymentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.weekOfMonth ,Calendar.Component.month, Calendar.Component.year], from: paymentDate)
        let currentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.weekOfMonth ,Calendar.Component.month, Calendar.Component.year], from: currentDate)
        
        guard let dateCompsDay = paymentDateComponents.day else { return nil } //return error alert
        guard let currentDateCompsDay = currentDateComponents.day else { return nil } //return error alert
        
        let differenceInDays = dateCompsDay - currentDateCompsDay
        
        guard let dateCompsMonth = paymentDateComponents.month else { return nil } //return error alert
        guard let currentDateCompsMonth = currentDateComponents.month else { return nil } //return error alert
        
        let differenceInMonths = dateCompsMonth - currentDateCompsMonth
        
        guard let dateCompsWeekOfMonth = paymentDateComponents.weekOfMonth else { return nil }
        guard let currentDateCompsWeekOfMonth = currentDateComponents.weekOfMonth else { return nil }
        
        if differenceInDays == 0 && differenceInMonths == 0 {
            return Upcoming.Today
        } else if differenceInDays == 1 && differenceInMonths == 0 {
            return Upcoming.Tomorrow
        } else if differenceInDays <= 7 && differenceInDays > 0 && dateCompsWeekOfMonth == currentDateCompsWeekOfMonth && differenceInMonths == 0 {
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
    
    init(serviceName: String, paymentFrequency: PaymentFrequency, serviceSymbol: Symbols, price: Double, subStartDate: Date, paymentDate: Date) {
        self.serviceName = serviceName
        self.paymentFrequency = paymentFrequency
        self.serviceSymbol = serviceSymbol
        self.price = price
        self.subStartDate = subStartDate
        self.paymentDate = paymentDate
    }
    
    func updatePayment() {
        
        if paymentIsDue {
            switch paymentFrequency {
            case .Weekly:
                paymentDate = paymentDate.nextWeek()
            case .Monthly:
                paymentDate = paymentDate.nextMonth()
            case .Quarterly:
                paymentDate = paymentDate.nextQuarter()
            case .BiAnnually:
                paymentDate = paymentDate.nextHalfYear()
            case .Annually:
                paymentDate = paymentDate.nextYear()
            }
        }
    }
}

//struct MockData {
//    static let service1 = Subscription(serviceName: "Apple TV+",
//                                       paymentFrequency: PaymentFrequency.Monthly,
//                                       serviceSymbol: Symbols.TV,
//                                       price: 14.99,
//                                       subStartDate: "19/07/2020")
//
//    static let service2 = Subscription(serviceName: "Netflix",
//                                       paymentFrequency: PaymentFrequency.Monthly,
//                                       serviceSymbol: Symbols.TV,
//                                       price: 19.99,
//                                       subStartDate: "19/07/2019")
//
//    static let service3 = Subscription(serviceName: "Spotify",
//                                       paymentFrequency: PaymentFrequency.Monthly,
//                                       serviceSymbol: Symbols.Music,
//                                       price: 10.99, subStartDate: "20/07/2018")
//
//    static let service4 = Subscription(serviceName: "Minecraft Server",
//                                       paymentFrequency: PaymentFrequency.Quarterly,
//                                       serviceSymbol: Symbols.Server,
//                                       price: 4.99, subStartDate: "23/07/2015")
//
//    static let services = [service1, service2, service3, service4]
//}

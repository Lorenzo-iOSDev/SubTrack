//
//  Subscription.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import Foundation

class Subscription: Identifiable, Codable{
    var id = UUID()
    
    let serviceName: String
    let paymentFrequency: PaymentFrequency
    let serviceSymbol: Symbols
    let price: Double
    let subStartDate: Date
    
    var paymentDate: Date// {
//        var newPaymentDate = Date()
//
//        if paymentIsDue {
//            switch paymentFrequency {
//            case .Weekly:
//                newPaymentDate = self.paymentDate.nextWeek()
//            case .Monthly:
//                newPaymentDate = self.paymentDate.nextMonth()
//            case .Quarterly:
//                newPaymentDate = self.paymentDate.nextQuarter()
//            case .BiAnnually:
//                newPaymentDate = self.paymentDate.nextHalfYear()
//            case .Annually:
//                newPaymentDate = self.paymentDate.nextYear()
//            }
//        }
//
//        return newPaymentDate
//    }
    
    var nextPaymentDate : Date {
        var newPaymentDate = Date()

        if paymentIsDue {
            switch paymentFrequency {
            case .Weekly:
                newPaymentDate = paymentDate.nextWeek()
                self.paymentDate = newPaymentDate
            case .Monthly:
                newPaymentDate = paymentDate.nextMonth()
                self.paymentDate = newPaymentDate
            case .Quarterly:
                newPaymentDate = paymentDate.nextQuarter()
                self.paymentDate = newPaymentDate
            case .BiAnnually:
                newPaymentDate = paymentDate.nextHalfYear()
                self.paymentDate = newPaymentDate
            case .Annually:
                newPaymentDate = paymentDate.nextYear()
                self.paymentDate = newPaymentDate
            }
        }

        return newPaymentDate
    }
    
    var paymentIsDue: Bool {
        let calendar = Calendar.autoupdatingCurrent
        
        //guard let paymentDate = paymentDate else { return nil } // return error alert
        
        if (calendar.isDateInYesterday(paymentDate)) {
            return true
        }
        
        return false
    }
    
    var firstPaymentDateSet: Bool = false
    
    var upcomingClassifier: Upcoming? {
        let calendar = Calendar.autoupdatingCurrent
        let currentDate = Date()
        
        //guard let paymentDate = paymentDate else { return nil } //return error alert
        
        let dateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: paymentDate)
        let currentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: currentDate)
        
        guard let dateCompsDay = dateComponents.day else { return nil } //return error alert
        guard let currentDateCompsDay = currentDateComponents.day else { return nil } //return error alert
        
        let differenceInDays = dateCompsDay - currentDateCompsDay
        
        guard let dateCompsMonth = dateComponents.month else { return nil } //return error alert
        guard let currentDateCompsMonth = currentDateComponents.month else { return nil } //return error alert
        
        let differenceInMonths = dateCompsMonth - currentDateCompsMonth
        
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
    
    init(serviceName: String, paymentFrequency: PaymentFrequency, serviceSymbol: Symbols, price: Double, subStartDate: Date, paymentDate: Date) {
        self.serviceName = serviceName
        self.paymentFrequency = paymentFrequency
        self.serviceSymbol = serviceSymbol
        self.price = price
        self.subStartDate = subStartDate
        self.paymentDate = paymentDate
    }
    
//    mutating func updatePaymentDate() {
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "dd/MM/yyyy"
//
//        if (firstPaymentDateSet == false) {
//            //if let startDate = dateFormatter.date(from: subStartDate) {
//                var nextPaymentDate = Date()
//
//                switch paymentFrequency {
//                    case .Weekly:
//                        nextPaymentDate = subStartDate.nextWeek()
//                    case .Monthly:
//                        nextPaymentDate = subStartDate.nextMonth()
//                    case .Quarterly:
//                        nextPaymentDate = subStartDate.nextQuarter()
//                    case .BiAnnually:
//                        nextPaymentDate = subStartDate.nextHalfYear()
//                    case .Annually:
//                        nextPaymentDate = subStartDate.nextYear()
//                    }
//
//                self.paymentDate = nextPaymentDate
//                self.firstPaymentDateSet = true
//        } else {
//                var nextPaymentDate = Date()
//
//                switch paymentFrequency {
//                    case .Weekly:
//                        nextPaymentDate = paymentDate.nextWeek()
//                    case .Monthly:
//                        nextPaymentDate = paymentDate.nextMonth()
//                    case .Quarterly:
//                        nextPaymentDate = paymentDate.nextQuarter()
//                    case .BiAnnually:
//                        nextPaymentDate = paymentDate.nextHalfYear()
//                    case .Annually:
//                        nextPaymentDate = paymentDate.nextYear()
//                    }
//
//                self.paymentDate = nextPaymentDate
//
//        }
//    }
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

//
//  Subscription.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import Foundation

final class Subscription: Identifiable, Codable, Equatable{
    
    //Universally Unique Identifier for the subscription
    var id = UUID()
    
    //Property variables for the subscription
    var serviceName: String
    var paymentFrequency: PaymentFrequency
    var serviceSymbol: Symbols
    var price: Double
    var subStartDate: Date
    var paymentDate: Date
    
    //Computed variable to automatically find out whether the subscriptions payment is due
    var paymentIsDue: Bool {
        let calendar = Calendar.autoupdatingCurrent
        
        let today = calendar.startOfDay(for: Date())
        
        if (paymentDate < today) {
            print("Payment date is \(paymentDate)")
            return true
        }
        
        return false
    }
    
    //Computed variable to classify wether the Subscription is due Today, Tomorrow, This Week or This Month
    //Does this by comparing difference in Date Components of Days Weeks and Months
    var upcomingClassifier: Upcoming? {
        let calendar = Calendar.autoupdatingCurrent
        let currentDate = Date()
        
        let paymentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.weekOfMonth ,Calendar.Component.month, Calendar.Component.year], from: paymentDate)
        let currentDateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.weekOfMonth ,Calendar.Component.month, Calendar.Component.year], from: currentDate)

        guard let dateCompsDay = paymentDateComponents.day else { return nil } //silently fail
        guard let currentDateCompsDay = currentDateComponents.day else { return nil } //silently fail
        
        let differenceInDays = dateCompsDay - currentDateCompsDay
        
        guard let dateCompsMonth = paymentDateComponents.month else { return nil } //silently fail
        guard let currentDateCompsMonth = currentDateComponents.month else { return nil } //silently fail
        
        let differenceInMonths = dateCompsMonth - currentDateCompsMonth
        
        guard let dateCompsWeekOfMonth = paymentDateComponents.weekOfMonth else { return nil } //silently fail
        guard let currentDateCompsWeekOfMonth = currentDateComponents.weekOfMonth else { return nil } //silently fail
        
        if differenceInDays == 0 && differenceInMonths == 0 {
            return Upcoming.Today
        } else if differenceInDays == 1 && differenceInMonths == 0 {
            return Upcoming.Tomorrow
        } else if differenceInDays <= 7 && dateCompsWeekOfMonth == currentDateCompsWeekOfMonth && differenceInMonths == 0 {
            return Upcoming.ThisWeek
        } else if dateCompsWeekOfMonth != currentDateCompsWeekOfMonth && differenceInMonths == 0 {
            return Upcoming.ThisMonth
        }
        
        return nil
    }
    
    //Computed property of sorting priority so that sortedSubscriptions array can sort based on something
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
    
    //Initializer
    init(serviceName: String, paymentFrequency: PaymentFrequency, serviceSymbol: Symbols, price: Double, subStartDate: Date, paymentDate: Date) {
        self.serviceName = serviceName
        self.paymentFrequency = paymentFrequency
        self.serviceSymbol = serviceSymbol
        self.price = price
        self.subStartDate = subStartDate
        self.paymentDate = paymentDate
    }
    
    // == Overload so that subscriptions can be equatable
    //will check if subscriptions UUIDs are the same
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    //Functions to update the payment date based on payment frequency
    func updatePayment() {
        while paymentIsDue {
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

//MockData sample data to use in previews
struct MockData {
    static let service1 = Subscription(serviceName: "Apple TV+",
                                       paymentFrequency: PaymentFrequency.Monthly,
                                       serviceSymbol: Symbols.TV,
                                       price: 14.99,
                                       subStartDate: Date(), paymentDate: Date())
}

//
//  AllSubscriptionsViewModel.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 4/07/21.
//

import SwiftUI

final class SubTrackViewModel: ObservableObject {
    
    //Saved Data
    @AppStorage("subscriptions") private var subscriptionsData: Data?
    
    //Subscription Arrays
    @Published var subscriptions: [Subscription] = [] // should be empty array, using mock data to test
    @Published var sortedSubscriptions: [Subscription] = []
    
    //Upcoming Subscriptions Arrays
    @Published var today: [Subscription] = []
    @Published var tomorrow: [Subscription] = []
    @Published var thisWeek: [Subscription] = []
    @Published var thisMonth: [Subscription] = []
    
    //View Dependent bool
    @Published var isShowingAddSubscription = false
    
    //AddSubscriptionView
    @Published var subName = ""
    @Published var subPrice = ""
    @Published var subDate = Date()
    @Published var paymentFreqPicked = 1
    @Published var symbolPicked = 0
    
    var currentDate = Date()
    
    var totalPrice: Double {
        var total = 0.00
        for sub in subscriptions {
            total += sub.price
        }
        
        return total
    }
    
    func filterSubscriptions() {
        today = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Today}
        tomorrow = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Tomorrow}
        thisWeek = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisWeek}
        thisMonth = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisMonth}
    }
    
    func addSubscription() {
        guard let priceDouble = Double(subPrice) else { return } // return error
        
        var paymentDate = Date()
        
        switch paymentFreqPicked {
        case 0:
            paymentDate = subDate.nextWeek()
            
        case 1:
            paymentDate = subDate.nextMonth()
        
        case 2:
            paymentDate = subDate.nextQuarter()
            
        case 3:
            paymentDate = subDate.nextHalfYear()
            
        case 4 :
            paymentDate = subDate.nextYear()
            
        default:
            paymentDate = subDate.nextMonth()
        }
        
        let newSub = Subscription(serviceName: subName,
                                  paymentFrequency: PaymentFrequency.allCases[paymentFreqPicked],
                                  serviceSymbol: Symbols.allCases[symbolPicked],
                                  price: priceDouble,
                                  subStartDate: subDate,
                                  paymentDate: paymentDate)
        
        subscriptions.append(newSub)
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        saveSubscriptions()
        resetFormFields()
    }
    
    func resetFormFields() {
        subName = ""
        subPrice = ""
        subDate = Date()
        paymentFreqPicked = 1
        symbolPicked = 0
    }
    
    func showAddSubscriptionsView() {
        isShowingAddSubscription = true
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
        
        saveSubscriptions()
        retrieveSubscriptions()
    }
    
    func saveSubscriptions() {
        //check if form is valid before saving
        
        do {
            let data = try JSONEncoder().encode(subscriptions)
            subscriptionsData = data
        } catch {
            //AlertItem for failed saving
            print("Failed to Save: Invalid Data")
        }
    }
    
    func retrieveSubscriptions() {
        guard let subscriptionsData = subscriptionsData else {
            return // error could not find data
        }
        
        do {
            subscriptions = try JSONDecoder().decode([Subscription].self, from: subscriptionsData)
        } catch {
            //AlertItem invalid data
            print("Failed to Load: Invalid Data")
        }
        
        //check for paymentUpdates
        checkForPaymentDates()
        
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        //Debugging
//        print(Date().startOfWeek())
        subscriptions.map { printSubscriptionUpcomingClassifiers($0) }
        subscriptions.map { printPaymentDates($0) }
//        print("\n \n sortedSubscription size: \(sortedSubscriptions.count)")
    }
    
    func checkForPaymentDates() {
        let dueUpdates = subscriptions.filter { $0.paymentIsDue } // this works because since Subscription is a class and not a Struct, it is referenced instead of copied.
        
        if !dueUpdates.isEmpty {
            //print(dueUpdates)
            
            for update in dueUpdates {
                //print(update.paymentDate)
                
                update.updatePayment()
                
                print(update.paymentDate)
                
                saveSubscriptions()
            }
        }
        
    }
    
    //Debugging functions
    func printPaymentDates(_ subscription: Subscription) {
        print("payment date for \(subscription.serviceName) is \(subscription.paymentDate)")
        //print("next payment date for \(subscription.serviceName) is \(subscription.nextPaymentDate)")
    }
    
    func printSubscriptionUpcomingClassifiers(_ subscription: Subscription) {
        print("upcoming classifier for \(subscription.serviceName) is \(String(describing: subscription.upcomingClassifier?.rawValue))")
    }
}

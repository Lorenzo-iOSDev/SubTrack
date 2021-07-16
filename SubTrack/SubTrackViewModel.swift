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
    
    func addSubscription() {
        guard let priceDouble = Double(subPrice) else { return } // return error
        
        let newSub = Subscription(serviceName: subName,
                                  paymentFrequency: PaymentFrequency.allCases[paymentFreqPicked].rawValue,
                                  serviceSymbol: Symbols.allCases[symbolPicked].rawValue,
                                  price: priceDouble,
                                  paymentDateString: subDate.toString())
        
        subscriptions.append(newSub)
        sortedSubscriptions.append(newSub)
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        
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
        
        sortedSubscriptions = subscriptions
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
    }
    
}

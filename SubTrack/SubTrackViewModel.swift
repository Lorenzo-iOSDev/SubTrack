//
//  AllSubscriptionsViewModel.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 4/07/21.
//

import SwiftUI

final class SubTrackViewModel: ObservableObject {
    
    //Subscription Arrays
    @Published var subscriptions: [Subscription] = MockData.services // should be empty array, using mock data to test
    @Published var sortedSubscriptions: [Subscription] = MockData.services.sorted(by: { $0.sortPriority < $1.sortPriority })
    
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
    
    var newSubscription: Subscription {
        Subscription(serviceName: subName, paymentFrequency: "Monthly", serviceSymbol: "tv", price: Double(subPrice) ?? 0.00, paymentDateString: subDate.toString())
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
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
    }
    
    
}

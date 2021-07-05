//
//  AllSubscriptionsViewModel.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 4/07/21.
//

import SwiftUI

final class SubTrackViewModel: ObservableObject {
    
    @Published var subscriptions: [Subscription] = MockData.services // should be empty array, using mock data to test
    @Published var sortedSubscriptions: [Subscription] = MockData.services.sorted(by: { $0.sortPriority < $1.sortPriority })
    
    var currentDate = Date()
    
    var totalPrice: Double {
        var total = 0.00
        for sub in subscriptions {
            total += sub.price
        }
        return total
    }
    
    func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
    }
}

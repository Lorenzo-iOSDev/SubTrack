//
//  UpcomingCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct UpcomingCard: View {
    
    var subscription: Subscription
    var upcomingClassifier: Upcoming?
    
    var body: some View {
        if upcomingClassifier != nil {
            VStack {
                
                HStack {
                    Text(upcomingClassifier!.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                SubscriptionCard(subscription: subscription)
            }
        }
    }
}

struct UpcomingCard_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingCard(subscription: MockData.service1, upcomingClassifier: Upcoming.Today)
    }
}

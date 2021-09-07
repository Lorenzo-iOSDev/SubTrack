//
//  UpcomingCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct UpcomingCards: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        VStack {
            
            if (viewModel.today.count != 0) {
                HStack {
                    Text(Upcoming.Today.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ForEach(viewModel.today) { subscription in
                    SubscriptionCard(viewModel: viewModel, subscription: subscription)
                }
            }
            
            if (viewModel.tomorrow.count != 0) {
                HStack {
                    Text(Upcoming.Tomorrow.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ForEach(viewModel.tomorrow) { subscription in
                    SubscriptionCard(viewModel: viewModel, subscription: subscription)
                }
            }
            
            if (viewModel.thisWeek.count != 0) {
                HStack {
                    Text(Upcoming.ThisWeek.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ForEach(viewModel.thisWeek) { subscription in
                    SubscriptionCard(viewModel: viewModel, subscription: subscription)
                }
            }
            
            if (viewModel.thisMonth.count != 0) {
                HStack {
                    Text(Upcoming.ThisMonth.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ForEach(viewModel.thisMonth) { subscription in
                    SubscriptionCard(viewModel: viewModel, subscription: subscription)
                }
            }
            
            if (viewModel.nextMonthBeyond.count != 0) {
                HStack {
                    Text(Upcoming.SubsequentMonths.rawValue)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ForEach(viewModel.nextMonthBeyond) { subscription in
                    SubscriptionCard(viewModel: viewModel, subscription: subscription)
                }
            }
        }
    }
}

struct UpcomingCard_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingCards(viewModel: SubTrackViewModel())
    }
}

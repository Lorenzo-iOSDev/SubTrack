//
//  UpcomingSubscriptionsView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct UpcomingSubscriptionsView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        VStack {
            HStack{
                Text("Upcoming Payments")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button {
                    print(viewModel.subscriptions[1].upcomingClassifier ?? "No value") 
                } label: {
                    AddButton()
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            ScrollView {
                
                ForEach(viewModel.sortedSubscriptions) { subscription in
                    UpcomingCard(subscription: subscription, upcomingClassifier: subscription.upcomingClassifier)
                }
            }
        }
    }
}

struct UpcomingSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingSubscriptionsView(viewModel: SubTrackViewModel())
    }
}

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
                
                HStack{
                    Image(systemName: subscription.serviceSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(subscription.serviceName)
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text(subscription.paymentFrequency)
                            .font(.body)
                            .italic()
                    }.padding(.leading)
                    Spacer()
                    
                    
                    Text("$\(subscription.price, specifier: "%.2f")")
                        .font(.title3)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(Color(.systemBackground))
                        .shadow(radius: 8))
                .padding(.horizontal, 10)
            }
        }
    }
}

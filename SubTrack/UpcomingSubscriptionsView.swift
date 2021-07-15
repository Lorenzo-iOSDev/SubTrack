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
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("Upcoming Payments")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Button {
                        viewModel.isShowingAddSubscription = true
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
            .sheet(isPresented: $viewModel.isShowingAddSubscription, content: {
                AddSubscriptionView(viewModel: viewModel)
        })
        }
        .onAppear() {
            viewModel.retrieveSubscriptions()
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
                
                SubscriptionCard(subscription: subscription)
            }
        }
    }
}

struct SubscriptionCard: View {
    
    var subscription: Subscription
    
    var body: some View {
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
                .foregroundColor(Color(.systemBackground)))
                //.shadow(radius: 8))
        .padding(.horizontal, 10)
    }
}

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
                        viewModel.showAddSubscriptionsView()
                    } label: {
                        AddButton()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                //Check if sortedSubscriptions array is nil or not
                //If Nil then show Empty State
                if (viewModel.sortedSubscriptions.count != 0) {
                    ScrollView {
                        UpcomingCards(viewModel: viewModel)
                    }
                } else {
                    Spacer()
                    
                    UpcomingEmptyState()
                    
                    Spacer()
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

struct UpcomingEmptyState: View {
    
    var body: some View {
        VStack {
            Text("No more upcoming \n payments this month.")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
        }
    }
}

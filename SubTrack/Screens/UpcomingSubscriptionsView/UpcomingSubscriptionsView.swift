//
//  UpcomingSubscriptionsView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct UpcomingSubscriptionsView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground)
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
            .preferredColorScheme(.light)
        
        UpcomingSubscriptionsView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.dark)
    }
}

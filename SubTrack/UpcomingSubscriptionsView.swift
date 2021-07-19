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
                
                ScrollView {
                    UpcomingCards(viewModel: viewModel)
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

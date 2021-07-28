//
//  ContentView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct AllSubscriptionsView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("All Subscriptions")
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
                
                VStack {
                    SubscriptionListCard(viewModel: viewModel)
                        
                    TotalCard(viewModel: viewModel)
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddSubscription, content: {
                AddSubscriptionView(viewModel: viewModel)})
        }
        .onAppear() {
            viewModel.retrieveSubscriptions()
        }
        .overlay(AllSubsEmptyState(viewModel: viewModel))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllSubscriptionsView(viewModel: SubTrackViewModel())
            
    }
}

struct AllSubsEmptyState: View {
    
    @ObservedObject var viewModel : SubTrackViewModel
    
    var body: some View {
        if viewModel.subscriptions.count == 0 {
                VStack {
                    Text("Press + to add a \n new subscription")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                }
        }
    }
}

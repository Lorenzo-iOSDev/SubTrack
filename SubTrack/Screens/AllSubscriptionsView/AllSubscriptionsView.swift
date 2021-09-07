//
//  ContentView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct AllSubscriptionsView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("All Subscriptions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    Button {
                        viewModel.isShowingAddSubscription = true
                    } label: {
                        AddButton()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                VStack {
                    SubscriptionListCard(viewModel: viewModel)
                        .disabled(viewModel.isShowingDetailView || viewModel.isShowingTotalDetailView)
                    
                    TotalCard(viewModel: viewModel)
                        .disabled(viewModel.isShowingDetailView || viewModel.isShowingTotalDetailView)
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddSubscription, content: {
                    AddSubscriptionView(viewModel: viewModel)})
            .blur(radius: viewModel.isShowingDetailView || viewModel.isShowingTotalDetailView ? 20.0 : 0.0)
            
            if viewModel.isShowingDetailView {
                SubscriptionDetailView(viewModel: viewModel)
                    .transition(.opacity)
            }
            
            Text("").hidden().sheet(isPresented: $viewModel.isShowingEditView) {
                EditSubscriptionView(viewModel: viewModel)
            }
            
            if viewModel.subscriptions.count == 0 && viewModel.isShowingTotalDetailView == false {
                AllSubsEmptyState()
            }
            
            if viewModel.isShowingTotalDetailView {
                TotalCostDetailView(viewModel: viewModel)
                    .transition(.opacity)
            }
        }
        .onAppear() {
            viewModel.retrieveSubscriptions()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllSubscriptionsView(viewModel: SubTrackViewModel())
            
        AllSubscriptionsView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.dark)
    }
}

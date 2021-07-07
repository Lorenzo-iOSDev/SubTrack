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
        VStack {
            HStack{
                Text("All Subscriptions")
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
            
            VStack {
                CardList(viewModel: viewModel)
                    
                TotalCard(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllSubscriptionsView(viewModel: SubTrackViewModel())
    }
}

struct AddButton: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundColor(.primary)
            .imageScale(.large)
            .padding(.all, 10)
    }
}

struct TotalCard: View {
    
    var viewModel: SubTrackViewModel
    
    var body: some View {
        Button {
            //action
        } label: {
            HStack{
                Text("Total Cost per Month")
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("$\(viewModel.totalPrice, specifier: "%.2f")")
                    .font(.title3)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color(.systemBackground))
                    .shadow(radius: 10))
            .padding(10)
            .padding(.bottom, 15)
        }
        .foregroundColor(.primary)
    }
}

struct CardList: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.subscriptions) { service in
                CardListCell(subscription: service)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(.systemBackground))
                .shadow(radius: 10))
        .padding(.horizontal, 10)
    }
}

struct CardListCell: View {
    
    var subscription: Subscription
    
    var body: some View {
        HStack{
            Image(systemName: subscription.serviceSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(subscription.serviceName)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(subscription.paymentFrequency)
                    .font(.body)
                    .italic()
            }.padding(.leading, 10)
            
            Spacer()
            
            Text("$\(subscription.price, specifier: "%.2f")")
                .font(.title3)
        }
    }
}

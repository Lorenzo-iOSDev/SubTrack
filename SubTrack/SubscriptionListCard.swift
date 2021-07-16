//
//  SubscriptionListCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct SubscriptionListCard: View {
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.subscriptions) { service in
                SubscriptionListCardCell(subscription: service)
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteSubscription(at: indexSet)
            })
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(.systemBackground)))
        .padding(.horizontal, 10)
    }
}

struct SubscriptionListCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListCard(viewModel: SubTrackViewModel())
    }
}

struct SubscriptionListCardCell: View {
    
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

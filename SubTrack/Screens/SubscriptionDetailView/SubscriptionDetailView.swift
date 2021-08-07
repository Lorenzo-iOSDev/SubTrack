//
//  SubscriptionDetailView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/08/21.
//

import SwiftUI

struct SubscriptionDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isShowingDetailView: Bool
    
    var selectedSubscription: Subscription
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Icon(systemName: selectedSubscription.serviceSymbol.rawValue, sizeMultiplier: 2.0)
                Text(selectedSubscription.serviceName)
                    .font(.title)
                    .fontWeight(.medium)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date Started")
                            .bold()
                            .padding(.vertical, 3)
                        Text("\(selectedSubscription.paymentFrequency.rawValue) cost")
                            .bold()
                            .padding(.vertical, 3)
                        Text("Total cost so far")
                            .bold()
                            .padding(.vertical, 3)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(selectedSubscription.subStartDate.toString())")
                            .padding(.vertical, 3)
                        Text("$\(selectedSubscription.price, specifier: "%.2f")")
                            .padding(.vertical, 3)
                        Text("$\(selectedSubscription.price * 12, specifier: "%.2f")")
                            .padding(.vertical, 3)
                    }
                    .padding()
                }
                .padding()
                
                HStack {
                    Button {
                        print("Edit Button Pressed")
                    } label: {
                        Text("Edit")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .frame(width: 120,height: 45)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("BlackWhite"), style: StrokeStyle(lineWidth: 3))
                                    .background(Color(.clear)))
                    }
                    .padding(.horizontal)
                    
                    Button {
                        print("Delete Button Pressed")
                    } label: {
                        Text("Delete")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color("WhiteBlack"))
                            .frame(width: 120,height: 45)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("BlackWhite"), style: StrokeStyle(lineWidth: 3))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("BlackWhite"))))
                    }
                    .padding(.horizontal)
                }
            }
        }
        .cornerRadius(8.0)
        .frame(width: 350, height: 450)
        .shadow(radius: 10)
        .overlay(
            Button {
                isShowingDetailView = false
            } label: {
                XDismissButton()
            }.padding(5)
            , alignment: .topTrailing)
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        SubscriptionDetailView(isShowingDetailView: .constant(true), selectedSubscription: MockData.service1)
            .preferredColorScheme(.light)
            
        SubscriptionDetailView(isShowingDetailView: .constant(true), selectedSubscription: MockData.service1)
            .preferredColorScheme(.dark)
    }
}

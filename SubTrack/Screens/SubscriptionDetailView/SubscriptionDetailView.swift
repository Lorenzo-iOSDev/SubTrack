//
//  SubscriptionDetailView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/08/21.
//

import SwiftUI

struct SubscriptionDetailView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Icon(systemName: viewModel.selectedSubscription!.serviceSymbol.rawValue, sizeMultiplier: 2.0)
                Text(viewModel.selectedSubscription!.serviceName)
                    .font(.title)
                    .fontWeight(.medium)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date Started")
                            .bold()
                            .padding(.vertical, 3)
                        Text("Next Payment")
                            .bold()
                            .padding(.vertical, 3)
                        Text("\(viewModel.selectedSubscription!.paymentFrequency.rawValue) cost")
                            .bold()
                            .padding(.vertical, 3)
                        Text("Total paid")
                            .bold()
                            .padding(.vertical, 3)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(viewModel.selectedSubscription!.subStartDate.toString())")
                            .padding(.vertical, 3)
                        Text("\(viewModel.selectedSubscription!.paymentDate.toString())")
                            .padding(.vertical,3)
                        Text("\(Currency.allCases[viewModel.currency].rawValue)\(viewModel.selectedSubscription!.price, specifier: "%.\(viewModel.decimalAmount)f")")
                            .padding(.vertical, 3)
                        Text("\(Currency.allCases[viewModel.currency].rawValue)\(viewModel.costSoFar(of: viewModel.selectedSubscription!), specifier: "%.\(viewModel.decimalAmount)f")")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .padding(.vertical, 3)
                    }
                    .padding()
                }
                .padding()
                
                HStack {
                    Button {
                        print("Edit Button Pressed")
                        viewModel.isShowingEditView = true
                        print(viewModel.isShowingEditView)
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
                        viewModel.deleteButtonPressed()
                    } label: {
                        Text("Delete")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color("WhiteBlack"))
                            .frame(width: 120, height: 45)
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
                withAnimation {
                    viewModel.isShowingDetailView = false
                }
            } label: {
                XDismissButton()
            }.padding(5)
            , alignment: .topTrailing)
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        SubscriptionDetailView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.light)
            
        SubscriptionDetailView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.dark)
    }
}

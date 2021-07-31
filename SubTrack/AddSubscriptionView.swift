//
//  AddSubscriptionView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Form {
                        
                        Section(header: Text("Subscription Details")) {
                            TextField("Name", text: $viewModel.subName)
                            TextField("Price", text: $viewModel.subPrice)
                            DatePicker("Payment Date", selection: $viewModel.subDate, in: Date().oneHundredYearsAgo...Date(), displayedComponents: .date)
                            Picker("Payment Frequency", selection: $viewModel.paymentFreqPicked) {
                                ForEach(PaymentFrequency.allCases.indices) { index in
                                    Text(PaymentFrequency.allCases[index].rawValue)
                                }
                            }
                        }

                        Section(header: Text("Subscription Icon")) {
                            Picker("Pick Icon", selection: $viewModel.symbolPicked) {
                                ForEach(Symbols.allCases.indices) { index in
                                    Image(systemName: Symbols.allCases[index].rawValue)
                                        .imageScale(.large)
                                        .frame(width: 44, height: 44)
                                }
                            }
                        }

                        Section {
                            Button {
                                viewModel.addSubscription()
                                viewModel.isShowingAddSubscription.toggle()
                            } label: {
                                Text("Add New Subscription")
                            }
                        }
                    }
                    .navigationTitle("Add Subscription")
                }
            }
        }
        .overlay(XDismissButton(isShowingAddView: $viewModel.isShowingAddSubscription), alignment: .topTrailing)
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(viewModel: SubTrackViewModel())
    }
}

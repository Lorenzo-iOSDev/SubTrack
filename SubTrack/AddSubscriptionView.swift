//
//  AddSubscriptionView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel

    @State private var subName = ""
    @State private var subPrice = ""
    @State private var subDate = Date()
    
    @State private var subPaymentFreq = 1
    
    @State private var symbolPicked = 0
    
    var newSubscription: Subscription {
        Subscription(serviceName: subName, paymentFrequency: "Monthly", serviceSymbol: "tv", price: Double(subPrice) ?? 0.00, paymentDateString: subDate.toString())
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        Section(header: Text("Subscription Details")) {
                            TextField("Name", text: $subName)
                            TextField("Price", text: $subPrice)
                            DatePicker("Payment Date", selection: $subDate, displayedComponents: [.date])
                            Picker("Payment Frequency", selection: $subPaymentFreq) {
                                ForEach(PaymentFrequency.allCases.indices) { index in
                                    Text(PaymentFrequency.allCases[index].rawValue)

                                }
                            }
                        }

                        Section(header: Text("Subscription Icon")) {
                            Picker("Pick Icon", selection: $symbolPicked) {
                                ForEach(Symbols.allCases.indices) { index in
                                    Image(systemName: Symbols.allCases[index].rawValue)
                                        .imageScale(.large)
                                        .frame(width: 44, height: 44)
                                }
                            }

                        }

                        Section {
                            Button {
                                let newSubscription = Subscription(serviceName: subName,
                                                                   paymentFrequency: "Monthly",
                                                                   serviceSymbol: "tv",
                                                                   price: Double(subPrice)!, // unwrap properly
                                                                   paymentDateString: subDate.toString())

                                viewModel.addSubscription(newSubscription)

                                viewModel.isShowingAddSubscription = false
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

//
//  AddSubscriptionView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        NavigationView {
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
                        NavigationLink("Pick Icon", destination: IconPickerView(viewModel: viewModel))
                    }
                    
                    Section {
                        Button {
                            viewModel.addSubscription()
                            viewModel.retrieveSubscriptions()
                            viewModel.isShowingAddSubscription.toggle()
                        } label: {
                            Text("Add New Subscription")
                        }
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
                .navigationTitle("Add Subscription")
            }
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = .clear
        }
        .overlay(XDismissButton(isShowingAddView: $viewModel.isShowingAddSubscription), alignment: .topTrailing)
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(viewModel: SubTrackViewModel())
    }
}

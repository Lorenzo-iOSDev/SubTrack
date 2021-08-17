//
//  EditSubscriptionView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 9/08/21.
//

import SwiftUI

struct EditSubscriptionView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Subscription Details")) {
                        TextField("Name", text: $viewModel.newName)
                        TextField("Price", text: $viewModel.newPrice)
                        DatePicker("Start Date", selection: $viewModel.newDate, in: Date().oneHundredYearsAgo...Date(), displayedComponents: .date)
                        Picker("Payment Frequency", selection: $viewModel.newPaymentFreq) {
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
                            viewModel.saveEdit()
                            //viewModel.retrieveSubscriptions()
                            viewModel.isShowingEditView = false
                        } label: {
                            Text("Save Subscription")
                        }
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
                .navigationTitle("Edit Subscription")
            }
        }
        .onAppear {
            viewModel.fillEditInfo()
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = .clear
        }
        .overlay(
            Button {
                viewModel.isShowingEditView = false
            } label: {
            XDismissButton()
            }.padding(), alignment: .topTrailing)
    }
}

//struct EditSubscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSubscriptionView(viewModel: SubTrackViewModel(), subscription: MockData.service1)
//    }
//}

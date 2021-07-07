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
    @State private var symbolPicked: Symbols?
    
    var newSubscription: Subscription {
        Subscription(serviceName: subName, paymentFrequency: "Monthly", serviceSymbol: "tv", price: Double(subPrice) ?? 0.00, paymentDateString: subDate.toString())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    
                    Section(header: Text("Subscription Details")) {
                        TextField("Name", text: $subName)
                        TextField("Price", text: $subPrice)
                        DatePicker("Payment Date", selection: $subDate, displayedComponents: [.date])
                        
    //                    Picker(selection: $symbolPicked, label: Text("Pick Icon"), content: {
    //                        ForEach(Symbols.allCases.indices) { symbolIndex in
    //                            Image(systemName: Symbols.allCases[symbolIndex].rawValue)
    //                        }
    //                    })
    //                    .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section(header: Text("Pick Icon")) {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 50) {
                                ForEach(Symbols.allCases.indices) { symbolIndex in
                                    Button {
                                        print("Tapped \(Symbols.allCases[symbolIndex].rawValue)")
                                    } label: {
                                        IconButton(iconName: Symbols.allCases[symbolIndex].rawValue)
                                    }
                                    .foregroundColor(.primary)
                                }
                            }.padding()
                        }
                        .frame(height: 100)
                        .padding(.horizontal, -20)
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
        .overlay(XDismissButton(isShowingAddView: $viewModel.isShowingAddSubscription), alignment: .topTrailing)
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(viewModel: SubTrackViewModel())
    }
}

struct IconButton: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .imageScale(.large)
            .frame(width: 44, height: 44)
            .background(Color(.systemBackground))
            .cornerRadius(8.0)
            .shadow(radius: 5)
    }
}

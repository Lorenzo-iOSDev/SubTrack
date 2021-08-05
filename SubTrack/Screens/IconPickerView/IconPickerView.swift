//
//  IconPickerView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 4/08/21.
//

import SwiftUI

struct IconPickerView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                SubscriptionCard(subscription: Subscription(serviceName: viewModel.subName,
                                                            paymentFrequency: PaymentFrequency.allCases[viewModel.paymentFreqPicked],
                                                            serviceSymbol: Symbols.allCases[viewModel.symbolPicked],
                                                            price: Double(viewModel.subPrice) ?? 0.00,
                                                            subStartDate: Date(), paymentDate: Date()))
                
                Spacer()
                    .frame(height: 100)
                
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(Symbols.allCases.indices) { symbol in
                        Button {
                            viewModel.symbolPicked = symbol
                        } label: {
                            Icon(systemName: Symbols.allCases[symbol].rawValue)
                        }.foregroundColor(.primary)
                    }
                    .padding(.vertical, 10)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)))
                .padding()
                
                Spacer()
            }
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(viewModel: SubTrackViewModel())
    }
}

struct Icon: View {
    
    var systemName: String
    var sizeMultiplier: CGFloat = 1.0
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35 * sizeMultiplier, height: 35 * sizeMultiplier)
            .padding()
    }
}

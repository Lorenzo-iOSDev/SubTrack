//
//  TotalCostDetailView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 20/08/21.
//

import SwiftUI

struct TotalCostDetailView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)
                .ignoresSafeArea()
            
            HStack(spacing: 5) {
                VStack {
                    Text("Cost per Day")
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("\(Currency.allCases[viewModel.currency].rawValue)\(viewModel.costPerDay, specifier: "%.\(viewModel.decimalAmount)f")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .padding(5)
                }.padding()
                
                VStack {
                    Text("Cost per Half Year")
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("\(Currency.allCases[viewModel.currency].rawValue)\(viewModel.costPerHalfYear, specifier: "%.\(viewModel.decimalAmount)f")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .padding(5)
                }.padding()
                
                VStack {
                    Text("Cost per Year")
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("\(Currency.allCases[viewModel.currency].rawValue)\(viewModel.costPerYear, specifier: "%.\(viewModel.decimalAmount)f")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .padding(5)
                }.padding()
            }
        }
        .frame(width: 350, height: 200)
        .cornerRadius(8.0)
        .shadow(radius: 10)
        .overlay(
            Button {
                withAnimation {
                    viewModel.isShowingTotalDetailView = false
                }
            } label: {
                XDismissButton()
            }.padding(5), alignment: .topTrailing)
    }
}

struct TotalCostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TotalCostDetailView(viewModel: SubTrackViewModel())
            .colorScheme(.light)
        
        TotalCostDetailView(viewModel: SubTrackViewModel())
            .colorScheme(.dark)
    }
}

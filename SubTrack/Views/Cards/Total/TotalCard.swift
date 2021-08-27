//
//  TotalCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct TotalCard: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.isShowingTotalDetailView = true
            }
        } label: {
            HStack{
                Text("Due this Month")
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("$\(viewModel.costThisMonth, specifier: "%.2f")")
                    .font(.title3)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)))
            .padding(10)
            .padding(.bottom, 15)
        }
        .foregroundColor(.primary)
    }
}

struct TotalCard_Previews: PreviewProvider {
    static var previews: some View {
        TotalCard(viewModel: SubTrackViewModel())
    }
}

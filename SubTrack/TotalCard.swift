//
//  TotalCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct TotalCard: View {
    
    var viewModel: SubTrackViewModel
    
    var body: some View {
        Button {
            //action
        } label: {
            HStack{
                Text("Total Cost per Month")
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("$\(viewModel.totalPrice, specifier: "%.2f")")
                    .font(.title3)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color(.systemBackground)))
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

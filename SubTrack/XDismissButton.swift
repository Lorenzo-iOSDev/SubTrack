//
//  XDismissButton.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import SwiftUI

struct XDismissButton: View {
    
    @Binding var isShowingAddView: Bool
    
    var body: some View {
        HStack{
            Spacer()
            
            Button {
                isShowingAddView = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
            }
        }.padding()
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton(isShowingAddView: .constant(false))
    }
}


//
//  AddButton.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundColor(.primary)
            .imageScale(.large)
            .padding(.all, 10)
    }
}
struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}

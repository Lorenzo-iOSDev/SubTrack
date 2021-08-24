//
//  AllSubsEmptyState.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 25/08/21.
//

import SwiftUI

struct AllSubsEmptyState: View {
    var body: some View {
        VStack {
            Text("Press + to add a \n new subscription")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
        }
    }
}

struct AllSubsEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        AllSubsEmptyState()
    }
}

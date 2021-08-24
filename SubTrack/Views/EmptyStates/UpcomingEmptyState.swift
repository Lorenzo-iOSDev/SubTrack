//
//  UpcomingEmptyState.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 25/08/21.
//

import SwiftUI

struct UpcomingEmptyState: View {
    var body: some View {
        VStack {
            Text("No more upcoming \n payments this month.")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
        }
    }
}

struct UpcomingEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEmptyState()
    }
}

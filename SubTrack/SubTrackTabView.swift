//
//  SubTrackTabView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct SubTrackTabView: View {
    var body: some View {
        TabView {
            AllSubscriptionsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("All")
                }
            
            UpcomingSubscriptionsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming")
                }
        }
    }
}

struct SubTrackTabView_Previews: PreviewProvider {
    static var previews: some View {
        SubTrackTabView()
    }
}

//
//  SubTrackTabView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct SubTrackTabView: View {
    
    @StateObject var viewModel = SubTrackViewModel()
    
    var body: some View {
        TabView {
            AllSubscriptionsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("All")
                }
            
            UpcomingSubscriptionsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming")
                }
            
            SettingsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(.primary)
    }
}

struct SubTrackTabView_Previews: PreviewProvider {
    static var previews: some View {
        SubTrackTabView()
        
        SubTrackTabView()
            .preferredColorScheme(.dark)
    }
}

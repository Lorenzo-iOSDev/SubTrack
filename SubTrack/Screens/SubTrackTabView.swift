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
        }
    }
}

struct SubTrackTabView_Previews: PreviewProvider {
    static var previews: some View {
        SubTrackTabView()
    }
}
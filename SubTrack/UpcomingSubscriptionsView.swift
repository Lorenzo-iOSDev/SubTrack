//
//  UpcomingSubscriptionsView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct UpcomingSubscriptionsView: View {
    var body: some View {
        VStack {
            HStack{
                Text("Upcoming")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button {
                    print("Add Button Pressed")
                } label: {
                    AddButton()
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            ScrollView {
                Card(upcomingWhen: "This Week")
                
                Card(upcomingWhen: "This Month")
                
                Card(upcomingWhen: "Next Month")
            }
        }
    }
}

struct UpcomingSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingSubscriptionsView()
    }
}

struct Card: View {
    
    var upcomingWhen = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(upcomingWhen)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
            }.padding(.horizontal, 10)
            
            HStack{
                Image(systemName: "tv")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading) {
                    Text("Apple TV+")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Monthly")
                        .font(.body)
                        .italic()
                }.padding(.leading)
                Spacer()
                
                
                Text("$14.99")
                    .font(.title3)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color(.systemBackground))
                    .shadow(radius: 8))
            .padding(.horizontal, 10)
        }
    }
}

//
//  ContentView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/07/21.
//

import SwiftUI

struct AllSubscriptionsView: View {
    var body: some View {
        ZStack {
            //NavigationView {
            VStack {
                HStack{
                    Text("All Subscriptions")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                VStack {
                        CardList()
                        
                        TotalCard()
                }
            }
               // .navigationTitle("All Subscriptions")
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllSubscriptionsView()
    }
}

struct TotalCard: View {
    var body: some View {
        HStack{
            Text("Total Cost per Month")
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
            
            
            Text("$14.99")
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(.systemBackground))
                .shadow(radius: 10))
        .padding(10)
        .padding(.bottom, 15)
    }
}

struct CardList: View {
    var body: some View {
        List{
            CardListCell()
            CardListCell()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(.systemBackground))
                .shadow(radius: 10))
        .padding(.horizontal, 10)
    }
}

struct CardListCell: View {
    
    var body: some View {
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
    }
}

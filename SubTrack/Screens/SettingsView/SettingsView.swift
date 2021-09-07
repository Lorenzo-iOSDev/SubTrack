//
//  SettingsView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 3/09/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    Button {
                        viewModel.isShowingAddSubscription = true
                    } label: {
                        AddButton()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                Form {
                    Section(header: Text("Displayed Currency")) {
                        Picker("Currency", selection: $viewModel.currency) {
                            ForEach(Currency.allCases.indices) { index in
                                Text(Currency.allCases[index].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Stepper("Decimal Amount: \(viewModel.decimalAmount)", value: $viewModel.decimalAmount, in: 0...2)
                    }
                    
                    Section(header: Text("About the App")) {
                        VStack() {
                            Icon(systemName: "heart.circle.fill", sizeMultiplier: 3.0)
                                .padding()
                            Text("Thank you to everyone who has downloaded and tried out the app and a special thanks everyone who helped during the development process.")
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                        }
                        
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("0.8.0")
                        }
                        
                        HStack {
                            Link("Developers Twitter", destination: URL(string: "https://twitter.com/Lorenzo_iOSdev")!)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.light)
        
        SettingsView(viewModel: SubTrackViewModel())
            .preferredColorScheme(.dark)
    }
}

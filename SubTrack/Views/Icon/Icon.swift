//
//  Icon.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 28/08/21.
//

import SwiftUI

struct Icon: View {
    
    var systemName: String
    var sizeMultiplier: CGFloat = 1.0
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35 * sizeMultiplier, height: 35 * sizeMultiplier)
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(systemName: Symbols.Film.rawValue)
    }
}

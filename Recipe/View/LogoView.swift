//
//  LogoView.swift
//  Recipe
//
//  Created by HS on 26/7/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image(systemName:"takeoutbag.and.cup.and.straw.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .foregroundColor(.white)
            .padding(.bottom, 50)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .preferredColorScheme(.dark)
    }
}

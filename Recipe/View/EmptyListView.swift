//
//  EmptyListView.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Image(systemName: "note.text")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                Text("No recipe yet")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("Tap the + button to add a new recipe.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}


struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}

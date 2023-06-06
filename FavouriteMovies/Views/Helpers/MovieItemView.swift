//
//  MovieItemView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import SwiftUI

struct MovieItemView: View {
    
    // MARK: Stored properties
    let name: String
    let genre: String
    let rating: Int

    // MARK: Computed properties
    
    // The user interface
    var body: some View {
        HStack(alignment: .top) {
            Text(name)
                .font(.title2)
                .padding(.bottom, 10)
            Spacer()
            
            Text("\(rating)/5")
                .font(.title)
        }
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(name: "Raiders of the Lost Ark",
                      genre: "Action",
                      rating: 5)
    }
}

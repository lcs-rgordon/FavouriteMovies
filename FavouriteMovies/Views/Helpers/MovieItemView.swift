//
//  MovieItemView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import Blackbird
import SwiftUI

struct MovieItemView: View {
    
    // MARK: Stored properties
    let movie: Blackbird.Row
    
    // MARK: Computed properties
    
    // The user interface
    var body: some View {
        
        if let name = movie["name"]?.stringValue,
           let genre = movie["genre"]?.stringValue,
           let rating = movie["rating"]?.intValue {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title3)
                        .bold()
                    Text(genre)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text("\(rating)/5")
                    .font(.title)
            }
            
        } else {
            Text("Did not find expected columns in row.")
        }
        
    }
}

struct MovieItemView_Previews: PreviewProvider {
    
    static let exampleMovie = Blackbird.Row(dictionaryLiteral:
                                                ("name", "Ghostbusters"),
                                                ("genre", "Comedy"),
                                                ("rating", 5)
    )
    
    static var previews: some View {
        MovieItemView(movie: exampleMovie)
    }
}

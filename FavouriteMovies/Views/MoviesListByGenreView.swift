//
//  MoviesListByGenreView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-06-06.
//

import Blackbird
import SwiftUI

struct MoviesListByGenreView: View {
    
    // MARK: Stored properties
    
    // The list of favourite movies, as read from the database, for a given genre
    @BlackbirdLiveQuery var movies: Blackbird.LiveResults<Blackbird.Row>
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        ForEach(movies.results, id: \.self) { currentMovie in
            
            if let name = currentMovie["name"]?.stringValue,
               let genre = currentMovie["genre"]?.stringValue,
               let rating = currentMovie["rating"]?.intValue {
                
                MovieItemView(name: name,
                              genre: genre,
                              rating: rating)
            }
            
        }
    }
    
    // MARK: Initializers
    init(genreId: Int) {
        
        // Initialize the live query
        _movies = BlackbirdLiveQuery(tableName: "Movie", { db in
            try await db.query("SELECT * FROM MoviesWithGenreNames WHERE genre_id = \(genreId)")
        })
        
    }
    
}

struct MoviesListByGenreView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MoviesListByGenreView(genreId: 1)
        }
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}

//
//  MoviesListView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import Blackbird
import SwiftUI

struct MoviesListView: View {

    // MARK: Stored properties
    
    // The list of favourite movies, as read from the database
    @BlackbirdLiveQuery(tableName: "Movie", { db in
        try await db.query("SELECT * FROM MoviesWithGenreNames")
    }) var movies
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(movies.results, id: \.self) { currentMovie in
                
                if let name = currentMovie["name"]?.stringValue,
                   let genre = currentMovie["genre"]?.stringValue,
                   let rating = currentMovie["rating"]?.intValue {
                    
                    MovieItemView(name: name,
                                  genre: genre,
                                  rating: rating)
                }
                
            }
            .navigationTitle("Favourite Movies")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddMovieView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddMovieView) {
                        AddMovieView()
                            .presentationDetents([.fraction(0.3)])
                    }
                }
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

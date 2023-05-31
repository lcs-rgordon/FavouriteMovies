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
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // The list of movies produced by joining the Movie and Genre tables
    @BlackbirdLiveQuery(tableName: "Movie", { db in
        try await db.query("SELECT * FROM MovieWithGenre")
    }) var movies
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                List(movies.results, id: \.self) { currentMovie in
                    
                    MovieItemView(movie: currentMovie)
                    
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
    
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

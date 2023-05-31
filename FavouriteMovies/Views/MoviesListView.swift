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
    
    // Attempt to auto-load movies
    @BlackbirdLiveQuery(tableName: "Movie", { db in
        try await db.query("SELECT * FROM Movie")
    }) var movies
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        let _ = print(dump(movies))
        let _ = print("⭐️")
        let _ = print(dump(movies.results))
        NavigationView {
            VStack {
                List(movies.results, id: \.self) { currentMovie in
                    
                    if let name = currentMovie["name"]?.stringValue,
                       let genre = currentMovie["genre_id"]?.intValue,
                       let rating = currentMovie["rating"]?.intValue {
                        
                        MovieItemView(name: name,
                                      genre: "\(genre)",
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
    
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

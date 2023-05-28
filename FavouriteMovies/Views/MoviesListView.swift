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
    @BlackbirdLiveModels({ db in
        try await Movie.read(from: db)
    }) var movies
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(movies.results) { currentMovie in
                MovieItemView(name: currentMovie.name,
                              genre: currentMovie.genre,
                              rating: currentMovie.rating)
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

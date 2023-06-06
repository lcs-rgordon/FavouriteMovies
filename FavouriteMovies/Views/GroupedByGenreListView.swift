//
//  GroupedByGenreListView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-31.
//

import Blackbird
import SwiftUI

struct GroupedByGenreListView: View {
    
    // MARK: Stored properties
    
    // The list of genres, as read from the database
    @BlackbirdLiveModels({ db in
        try await Genre.read(from: db, orderBy: .ascending(\.$name))
    }) var genres
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(genres.results) { currentGenre in
                Section(content: {
                    MoviesListByGenreView(genreId: currentGenre.id)
                }, header: {
                    Text(currentGenre.name)
                })
            }
            .listStyle(.grouped)
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
            .navigationTitle("Favourite Movies")
        }
    }}

struct GroupedByGenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedByGenreListView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

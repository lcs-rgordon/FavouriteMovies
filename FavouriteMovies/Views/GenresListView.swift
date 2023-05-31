//
//  GenresListView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-31.
//

import Blackbird
import SwiftUI

struct GenresListView: View {
    // MARK: Stored properties
    
    // The list of genres, as read from the database
    @BlackbirdLiveModels({ db in
        try await Genre.read(from: db)
    }) var genres
    
    // Is the interface to add a genre visible right now?
    @State var showingAddGenreView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(genres.results) { currentGenre in
                Text(currentGenre.name)
            }
            .navigationTitle("Genres")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddGenreView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddGenreView) {
                        AddGenreView()
                            .presentationDetents([.fraction(0.15)])
                    }
                }
            }
        }
    }}

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        GenresListView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

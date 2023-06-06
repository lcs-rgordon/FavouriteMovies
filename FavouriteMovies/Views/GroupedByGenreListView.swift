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
    
    // The list of genres, with related statistics
    @BlackbirdLiveQuery(tableName: "Movie", { db in
        try await db.query("SELECT * FROM GenresWithStatistics")
    }) var genres

    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(genres.results, id: \.self) { currentGenre in
                if let genre_id = currentGenre["genre_id"]?.intValue,
                   let genre = currentGenre["genre"]?.stringValue,
                   let movieCount = currentGenre["movieCount"]?.intValue,
                   let averageRating = currentGenre["averageRating"]?.doubleValue {

                    NavigationLink(destination: {
                        MoviesListByGenreView(genreId: genre_id,
                                              genreName: genre)
                    }, label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(genre)
                                    .font(.title3)
                                    .bold()
                                Text("\(movieCount) titles")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Average ★:")
                                Text("\(averageRating.formatted())/5")
                                    .bold()
                            }
                                
                        }
                    })

                }
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
    }
        
}

struct GroupedByGenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedByGenreListView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

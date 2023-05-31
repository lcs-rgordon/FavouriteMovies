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

    // The list of favourite movies, as read from the database
    @State var movies: [MovieWithGenre] = []
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMovieView = false
    
    // Has a movie been added? Time to refresh this view...
    @State var movieWasAdded = false
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(movies, id: \.self) { currentMovie in
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
                        AddMovieView(movieWasAdded: $movieWasAdded)
                            .presentationDetents([.fraction(0.3)])
                    }
                }
            }
        }
        .task {
            await refreshMovies()
        }
        .onChange(of: movieWasAdded) { _ in
            Task {
                await refreshMovies()
            }
        }
        
    }
    
    func refreshMovies() async {
        // Clear the list of favourite movies
        movies = []
        
        // Refresh the list of favourite movies
        do {
            for row in try await db!.query("SELECT * FROM MovieWithGenre") {
                guard let id = row["id"]?.intValue,
                      let name = row["name"]?.stringValue,
                      let genre = row["genre"]?.stringValue,
                      let rating = row["rating"]?.intValue else {
                    print("Could not read row data")
                    continue
                }
                movies.append(MovieWithGenre(id: id,
                                             name: name,
                                             genre: genre,
                                             rating: rating))
                print(id)
                print(name)
                print(genre)
                print(rating)
                print("----")
            }
        } catch {
            print(error)
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

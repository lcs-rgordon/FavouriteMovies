//
//  FavouriteMoviesApp.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import Blackbird
import SwiftUI

@main
struct FavouriteMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesListView()
                    // Make the database available to all other view through the environment
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Image(systemName: "popcorn")
                        Text("Movies")
                    }

                GenresListView()
                    // Make the database available to all other view through the environment
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem {
                        Image(systemName: "questionmark.folder")
                        Text("Genres")
                    }
            }
        }
    }
}

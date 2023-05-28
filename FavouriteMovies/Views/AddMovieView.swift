//
//  AddMovieView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-28.
//

import Blackbird
import SwiftUI

struct AddMovieView: View {
    
    // MARK: Stored properties
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // Holds details for the new movie
    @State var name = ""
    @State var genre = ""
    @State var rating = 3
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the movie name", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("What is the movie's genre?", text: $genre)
                    .textFieldStyle(.roundedBorder)

                Picker(selection: $rating,
                       label: Text("Picker Name"),
                       content: {
                    Text("★").tag(1)
                    Text("★★").tag(2)
                    Text("★★★").tag(3)
                    Text("★★★★").tag(4)
                    Text("★★★★★").tag(5)
                })
                .pickerStyle(.segmented)

                Spacer()
            }
            .padding(5)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        addMovie()
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
    
    // MARK: Functions
    
    func addMovie() {
        // Write to database
        Task {
            try await db!.transaction { core in
                try core.query("""
                            INSERT INTO movie (
                                name,
                                genre,
                                rating
                            )
                            VALUES (
                                (?),
                                (?),
                                (?)
                            )
                            """,
                            name,
                            genre,
                            rating)
            }
            // Reset input fields after writing to database
            name = ""
            genre = ""
            rating = 3
        }

    }
    
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}

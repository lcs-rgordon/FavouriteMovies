//
//  AddGenreView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-31.
//

import Blackbird
import SwiftUI

struct AddGenreView: View {
    
    // MARK: Stored properties
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // Holds details for a newly defined genre
    @State var genre = ""
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the genre name", text: $genre)
                    .textFieldStyle(.roundedBorder)

                Spacer()
            }
            .padding(5)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        addGenre()
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
    
    // MARK: Functions
    
    func addGenre() {
        // Write to database
        Task {
            try await db!.transaction { core in
                try core.query("""
                            INSERT INTO genre (
                                name
                            )
                            VALUES (
                                (?)
                            )
                            """,
                            genre)
            }
            // Reset input fields after writing to database
            genre = ""
        }

    }}

struct AddGenreView_Previews: PreviewProvider {
    static var previews: some View {
        AddGenreView()
    }
}

//
//  AddMovieView.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-28.
//

import SwiftUI

struct AddMovieView: View {
    
    // MARK: Stored properties
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
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView()
    }
}

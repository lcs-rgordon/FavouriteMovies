//
//  MovieWithGenre.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-31.
//

import Blackbird
import Foundation

struct MovieWithGenre: BlackbirdModel {
    
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var genre: String
    @BlackbirdColumn var rating: Int
    
}

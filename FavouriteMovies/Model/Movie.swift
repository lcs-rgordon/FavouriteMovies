//
//  Movie.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import Blackbird
import Foundation

struct Movie: BlackbirdModel {
    
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var genre_id: Int
    @BlackbirdColumn var rating: Int
    
}

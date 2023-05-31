//
//  Movie.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-05-27.
//

import Blackbird
import Foundation

struct Genre: BlackbirdModel {
    
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    
}

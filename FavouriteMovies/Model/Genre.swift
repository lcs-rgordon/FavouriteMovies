//
//  Genre.swift
//  FavouriteMovies
//
//  Created by Russell Gordon on 2023-06-03.
//

import Blackbird
import Foundation

struct Genre: BlackbirdModel {
    
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    
}

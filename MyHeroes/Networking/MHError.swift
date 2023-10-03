//
//  MHError.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import Foundation

public enum MHError: String, Error {
    case unableToComplete     = "Unable to complete your request. Please check your internet connection"
    case invalidResponse      = "Invalid response from the server. Please try again"
    case invalidData          = "The data received from the server was invalid. Please try again."
    case unableToFavorite     = "There was an error favoriting this Hero. Please try again."
    case alreadyInFavorites   = "You've already favorited this Hero. You must REALLY like them!"
    case invalidURL
}

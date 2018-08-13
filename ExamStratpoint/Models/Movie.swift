//
//  Movie.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

struct Movie: Decodable {
    let rating: Float
    let genres: [String]
    let language: String
    let title: String
    let url: String
    let titleLong: String
    let imdbCode: String
    let id: Int
    let state: String
    let year: Int
    let runtime: Int
    let overview: String
    let slug: String
    let mpaRating: String
    
    enum CodingKeys: String, CodingKey {
        case rating
        case genres
        case language
        case title
        case url
        case titleLong = "title_long"
        case imdbCode = "imdb_code"
        case id
        case state
        case year
        case runtime
        case overview
        case slug
        case mpaRating = "mpa_rating"
    }
}

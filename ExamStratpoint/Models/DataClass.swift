//
//  DataClass.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

struct DataClass: Decodable {
    let movies: [Movie]
    let pageNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case movies
        case pageNumber = "page_number"
    }
}

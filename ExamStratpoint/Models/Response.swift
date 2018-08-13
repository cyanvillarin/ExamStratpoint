//
//  Response.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

struct Response: Decodable {
    let status: String
    let data: DataClass
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case statusMessage = "status_message"
    }
}

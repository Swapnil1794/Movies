//
//  Business.swift
//  SKYCORE
//
//  Created by Swapnil Gavali on 08/01/21.
//

import Foundation

struct ResponceModel:Codable {
    
    let page:Int
    let totalPages:Int
    let totalResults:Int
    let dates:Dates?
    let movies:[Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case dates = "dates"
        case movies = "results"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.dates = try container.decodeIfPresent(Dates.self, forKey: .dates)
        self.movies = try container.decodeIfPresent([Movie].self, forKey: .movies)
    
    }
}



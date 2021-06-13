//
//  Location.swift
//  Zimozi
//
//  Created by Swapnil Gavali on 22/05/21.
//

import Foundation
struct Dates : Codable { 
    
    let maximum:String
    let minimum:String
    
    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maximum = try container.decode(String.self, forKey: .maximum)
        self.minimum = try container.decode(String.self, forKey: .minimum)
       
    }
    
 
}


//
//  BusinessRequestModel.swift
//  SKYCORE
//
//  Created by Swapnil Gavali on 10/01/21.
//

import Foundation
struct RequestModel : Encodable {
    
    var apiKey:String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(apiKey, forKey: .apiKey)
    }
    
}

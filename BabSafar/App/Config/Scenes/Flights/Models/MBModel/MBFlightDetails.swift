//
//  MBFlightDetails.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation

struct MBFlightDetails : Codable {
  
   
    let summery : [Summary]?

    enum CodingKeys: String, CodingKey {
       
        case summery = "summary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        summery = try values.decodeIfPresent([Summary].self, forKey: .summery)
    }

}

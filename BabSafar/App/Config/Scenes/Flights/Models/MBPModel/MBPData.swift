//
//  MBPData.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation


struct MBPData : Codable {
    let post_data : Post_data?

    enum CodingKeys: String, CodingKey {

        case post_data = "post_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
    }

}

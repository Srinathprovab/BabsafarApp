//
//  QForm_fields.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation


struct QForm_fields : Codable {
    let options : [QOptions]?
    let title : String?
    let max_characters : Int?
    let image_size_x : Int?
    let type : String?
    let required : Bool?
    let option_id : Int?
    let image_size_y : Int?

    enum CodingKeys: String, CodingKey {

        case options = "options"
        case title = "title"
        case max_characters = "max_characters"
        case image_size_x = "image_size_x"
        case type = "type"
        case required = "required"
        case option_id = "option_id"
        case image_size_y = "image_size_y"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        options = try values.decodeIfPresent([QOptions].self, forKey: .options)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        max_characters = try values.decodeIfPresent(Int.self, forKey: .max_characters)
        image_size_x = try values.decodeIfPresent(Int.self, forKey: .image_size_x)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        required = try values.decodeIfPresent(Bool.self, forKey: .required)
        option_id = try values.decodeIfPresent(Int.self, forKey: .option_id)
        image_size_y = try values.decodeIfPresent(Int.self, forKey: .image_size_y)
    }

}

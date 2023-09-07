//
//  QFrom.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation


struct QFrom : Codable {
    let id : Int?
    let discount : Int?
    let discount_type : String?
    let discount_amount : Int?
    let sku : String?
    let type : String?
    let api_price : String?
    let price : Int?
    let discounted_price : Int?
    let form_fields : [QForm_fields]?
    let currency : String?
    let name : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case discount = "discount"
        case discount_type = "discount_type"
        case discount_amount = "discount_amount"
        case sku = "sku"
        case type = "type"
        case api_price = "api_price"
        case price = "price"
        case discounted_price = "discounted_price"
        case form_fields = "form_fields"
        case currency = "currency"
        case name = "name"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        discount_type = try values.decodeIfPresent(String.self, forKey: .discount_type)
        discount_amount = try values.decodeIfPresent(Int.self, forKey: .discount_amount)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        api_price = try values.decodeIfPresent(String.self, forKey: .api_price)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        discounted_price = try values.decodeIfPresent(Int.self, forKey: .discounted_price)
        form_fields = try values.decodeIfPresent([QForm_fields].self, forKey: .form_fields)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}

//
//  MBPriceDetails.swift
//  BabSafar
//
//  Created by FCI on 13/07/23.
//

import Foundation

struct MBPriceDetails : Codable {
    let api_currency : String?
    let adultsBasePrice : String?
    let childBasePrice : String?
    let infantBasePrice : String?
    let adultsTaxPrice : String?
    let childTaxPrice : String?
    let infantTaxPrice : String?
    let adultsTotalPrice : String?
    let childTotalPrice : String?
    let infantTotalPrice : String?
    let sub_total_adult : String?
    let sub_total_child : String?
    let sub_total_infant : String?
    let grand_total : String?
    let total_price_withoutmarkup : String?
    let admin_markup : String?
    let admin_discount : String?

    enum CodingKeys: String, CodingKey {

        case api_currency = "api_currency"
        case adultsBasePrice = "adultsBasePrice"
        case childBasePrice = "childBasePrice"
        case infantBasePrice = "infantBasePrice"
        case adultsTaxPrice = "adultsTaxPrice"
        case childTaxPrice = "childTaxPrice"
        case infantTaxPrice = "infantTaxPrice"
        case adultsTotalPrice = "adultsTotalPrice"
        case childTotalPrice = "childTotalPrice"
        case infantTotalPrice = "infantTotalPrice"
        case sub_total_adult = "sub_total_adult"
        case sub_total_child = "sub_total_child"
        case sub_total_infant = "sub_total_infant"
        case grand_total = "grand_total"
        case total_price_withoutmarkup = "total_price_withoutmarkup"
        case admin_markup = "admin_markup"
        case admin_discount = "admin_discount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
        adultsBasePrice = try values.decodeIfPresent(String.self, forKey: .adultsBasePrice)
        childBasePrice = try values.decodeIfPresent(String.self, forKey: .childBasePrice)
        infantBasePrice = try values.decodeIfPresent(String.self, forKey: .infantBasePrice)
        adultsTaxPrice = try values.decodeIfPresent(String.self, forKey: .adultsTaxPrice)
        childTaxPrice = try values.decodeIfPresent(String.self, forKey: .childTaxPrice)
        infantTaxPrice = try values.decodeIfPresent(String.self, forKey: .infantTaxPrice)
        adultsTotalPrice = try values.decodeIfPresent(String.self, forKey: .adultsTotalPrice)
        childTotalPrice = try values.decodeIfPresent(String.self, forKey: .childTotalPrice)
        infantTotalPrice = try values.decodeIfPresent(String.self, forKey: .infantTotalPrice)
        sub_total_adult = try values.decodeIfPresent(String.self, forKey: .sub_total_adult)
        sub_total_child = try values.decodeIfPresent(String.self, forKey: .sub_total_child)
        sub_total_infant = try values.decodeIfPresent(String.self, forKey: .sub_total_infant)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        total_price_withoutmarkup = try values.decodeIfPresent(String.self, forKey: .total_price_withoutmarkup)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        admin_discount = try values.decodeIfPresent(String.self, forKey: .admin_discount)
    }

}

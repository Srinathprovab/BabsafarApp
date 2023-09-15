//
//  PHotelSearchResult.swift
//  BabSafar
//
//  Created by FCI on 11/09/23.
//

import Foundation

struct PHotelSearchResult : Codable {
    let booking_source : String?
    let hotel_code : String?
    let city_code : String?
    let country_code : String?
    let name : String?
    let address : String?
    let phone_number : String?
    let fax : String?
    let email : String?
    let hotel_desc : Hotel_desc?
    let image : String?
    let thumb_image : String?
    let accomodation_cstr : String?
    let location : String?
    let star_rating : String?
    let latitude : String?
    let longitude : String?
    let facility_cstr : String?
    let facility : [PHFacility]?
    let price : String?
    let hotel_details_room : String?
    let refund : String?
    let currency : String?
    let resultIndex : String?
    let frmpd : String?
    let no_of_nights : Int?
    let filter_sumry : Filter_sumry?
    let hotel_shortdesc : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case hotel_code = "hotel_code"
        case city_code = "city_code"
        case country_code = "country_code"
        case name = "name"
        case address = "address"
        case phone_number = "phone_number"
        case fax = "fax"
        case email = "email"
        case hotel_desc = "hotel_desc"
        case image = "image"
        case thumb_image = "thumb_image"
        case accomodation_cstr = "accomodation_cstr"
        case location = "location"
        case star_rating = "star_rating"
        case latitude = "latitude"
        case longitude = "longitude"
        case facility_cstr = "facility_cstr"
        case facility = "facility"
        case price = "price"
        case hotel_details_room = "hotel_details_room"
        case refund = "refund"
        case currency = "currency"
        case resultIndex = "ResultIndex"
        case frmpd = "frmpd"
        case no_of_nights = "no_of_nights"
        case filter_sumry = "filter_sumry"
        case hotel_shortdesc = "hotel_shortdesc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        hotel_desc = try values.decodeIfPresent(Hotel_desc.self, forKey: .hotel_desc)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        facility = try values.decodeIfPresent([PHFacility].self, forKey: .facility)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        hotel_details_room = try values.decodeIfPresent(String.self, forKey: .hotel_details_room)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        resultIndex = try values.decodeIfPresent(String.self, forKey: .resultIndex)
        frmpd = try values.decodeIfPresent(String.self, forKey: .frmpd)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        filter_sumry = try values.decodeIfPresent(Filter_sumry.self, forKey: .filter_sumry)
        hotel_shortdesc = try values.decodeIfPresent(String.self, forKey: .hotel_shortdesc)
    }

}

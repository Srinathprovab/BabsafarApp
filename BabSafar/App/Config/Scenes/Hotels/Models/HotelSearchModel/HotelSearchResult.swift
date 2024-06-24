

import Foundation
struct HotelSearchResult : Codable {
    let booking_source : String?
    let location : String?
    let star_rating : Int?
    let country_code : String?
    let image : String?
    let accomodation_cstr : String?
    let facility_cstr : String?
    let data_mode : String?
    let city_code : String?
    let hotel_code : String?
    let fax : String?
    let city_name : String?
    let hotel_desc : String?
    let latitude : String?
    let name : String?
    let currency : String?
    let xml_currency : String?
    let no_of_nights : Int?
    let facility : [HFacility]?
    let giata_id : String?
    let country_name : String?
    let phone_number : String?
    let email : String?
    let longitude : String?
    let hotel_shortdesc : String?
    let thumb_image : String?
    let xml_price : String?
    let refund : String?
    let price : String?
    let address : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case location = "location"
        case star_rating = "star_rating"
        case country_code = "country_code"
        case image = "image"
        case accomodation_cstr = "accomodation_cstr"
        case facility_cstr = "facility_cstr"
        case data_mode = "data_mode"
        case city_code = "city_code"
        case hotel_code = "hotel_code"
        case fax = "fax"
        case city_name = "city_name"
        case hotel_desc = "hotel_desc"
        case latitude = "latitude"
        case name = "name"
        case currency = "currency"
        case xml_currency = "xml_currency"
        case no_of_nights = "no_of_nights"
        case facility = "facility"
        case giata_id = "giata_id"
        case country_name = "country_name"
        case phone_number = "phone_number"
        case email = "email"
        case longitude = "longitude"
        case hotel_shortdesc = "hotel_shortdesc"
        case thumb_image = "thumb_image"
        case xml_price = "xml_price"
        case refund = "refund"
        case price = "price"
        case address = "address"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        data_mode = try values.decodeIfPresent(String.self, forKey: .data_mode)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        hotel_desc = try values.decodeIfPresent(String.self, forKey: .hotel_desc)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        facility = try values.decodeIfPresent([HFacility].self, forKey: .facility)
        giata_id = try values.decodeIfPresent(String.self, forKey: .giata_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        hotel_shortdesc = try values.decodeIfPresent(String.self, forKey: .hotel_shortdesc)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        xml_price = try values.decodeIfPresent(String.self, forKey: .xml_price)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        address = try values.decodeIfPresent(String.self, forKey: .address)
    }

}



import Foundation
struct HotelSearchResult : Codable {
    let booking_source : String?
    let hotel_desc : Hotel_desc?
    let currency : String?
    //  let dis_mar : Dis_mar?
    let city_code : String?
    let address : String?
    let location : String?
    let data_mode : String?
    let phone_number : String?
    let hotel_dis_mar_parm : String?
    let country_name : String?
    let thumb_image : String?
    let email : String?
    let image : String?
    let xml_price : String?
    let no_of_nights : Int?
    let name : String?
    let giata_id : String?
    let longitude : String?
    let accomodation_cstr : String?
    let star_rating : Int?
    let price : String?
    let facility_cstr : String?
    let org_price : String?
    let hotel_code : Int?
    let country_code : String?
    let city_name : String?
    let fax : String?
    let hotel_shortdesc : String?
    let facility : [HFacility]?
    let xml_currency : String?
    let xml_net : String?
    let refund : String?
    let latitude : String?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_source = "booking_source"
        case hotel_desc = "hotel_desc"
        case currency = "currency"
        //   case dis_mar = "dis_mar"
        case city_code = "city_code"
        case address = "address"
        case location = "location"
        case data_mode = "data_mode"
        case phone_number = "phone_number"
        case hotel_dis_mar_parm = "hotel_dis_mar_parm"
        case country_name = "country_name"
        case thumb_image = "thumb_image"
        case email = "email"
        case image = "image"
        case xml_price = "xml_price"
        case no_of_nights = "no_of_nights"
        case name = "name"
        case giata_id = "giata_id"
        case longitude = "longitude"
        case accomodation_cstr = "accomodation_cstr"
        case star_rating = "star_rating"
        case price = "price"
        case facility_cstr = "facility_cstr"
        case org_price = "org_price"
        case hotel_code = "hotel_code"
        case country_code = "country_code"
        case city_name = "city_name"
        case fax = "fax"
        case hotel_shortdesc = "hotel_shortdesc"
        case facility = "facility"
        case xml_currency = "xml_currency"
        case xml_net = "xml_net"
        case refund = "refund"
        case latitude = "latitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        hotel_desc = try values.decodeIfPresent(Hotel_desc.self, forKey: .hotel_desc)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        //      dis_mar = try values.decodeIfPresent(Dis_mar.self, forKey: .dis_mar)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        data_mode = try values.decodeIfPresent(String.self, forKey: .data_mode)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        hotel_dis_mar_parm = try values.decodeIfPresent(String.self, forKey: .hotel_dis_mar_parm)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        xml_price = try values.decodeIfPresent(String.self, forKey: .xml_price)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        giata_id = try values.decodeIfPresent(String.self, forKey: .giata_id)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        org_price = try values.decodeIfPresent(String.self, forKey: .org_price)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        hotel_shortdesc = try values.decodeIfPresent(String.self, forKey: .hotel_shortdesc)
        facility = try values.decodeIfPresent([HFacility].self, forKey: .facility)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
    }
    
}

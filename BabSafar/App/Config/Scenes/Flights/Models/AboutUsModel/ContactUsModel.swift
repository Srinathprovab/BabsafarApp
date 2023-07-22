//
//  ContactUsModel.swift
//  BabSafar
//
//  Created by FCI on 16/02/23.
//

import Foundation

struct ContactUsModel: Codable  {
    let data : ContactUsData?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ContactUsData.self, forKey: .data)
    }
    
}



struct ContactUsData : Codable {
    let origin : String?
    let balance : String?
    let currency_converter_fk : String?
    let domain_name : String?
    let domain_ip : String?
    let domain_key : String?
    let theme_id : String?
    let b2b_theme_id : String?
    let status : String?
    let comment : String?
    let domain_logo : String?
    let domain_logo_1 : String?
    let created_by_id : String?
    let created_datetime : String?
    let test_username : String?
    let test_password : String?
    let live_username : String?
    let live_password : String?
    let phone : String?
    let whatsapp : String?
    let email : String?
    let support_email : String?
    let address : String?
    let address_ar : String?
    let api_country_list_fk : String?
    let api_city_list_fk : String?
    let insta_url : String?
    let twitter_url : String?
    let facebook_url : String?
    let linkedin_url : String?
    let snapchat_url : String?
    let support_url : String?
    let copyright : String?
    
    enum CodingKeys: String, CodingKey {
        
        case origin = "origin"
        case balance = "balance"
        case currency_converter_fk = "currency_converter_fk"
        case domain_name = "domain_name"
        case domain_ip = "domain_ip"
        case domain_key = "domain_key"
        case theme_id = "theme_id"
        case b2b_theme_id = "b2b_theme_id"
        case status = "status"
        case comment = "comment"
        case domain_logo = "domain_logo"
        case domain_logo_1 = "domain_logo_1"
        case created_by_id = "created_by_id"
        case created_datetime = "created_datetime"
        case test_username = "test_username"
        case test_password = "test_password"
        case live_username = "live_username"
        case live_password = "live_password"
        case phone = "phone"
        case whatsapp = "whatsapp"
        case email = "email"
        case support_email = "support_email"
        case address = "address"
        case address_ar = "address_ar"
        case api_country_list_fk = "api_country_list_fk"
        case api_city_list_fk = "api_city_list_fk"
        case insta_url = "insta_url"
        case twitter_url = "twitter_url"
        case facebook_url = "facebook_url"
        case linkedin_url = "linkedin_url"
        case snapchat_url = "snapchat_url"
        case support_url = "support_url"
        case copyright = "copyright"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        balance = try values.decodeIfPresent(String.self, forKey: .balance)
        currency_converter_fk = try values.decodeIfPresent(String.self, forKey: .currency_converter_fk)
        domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
        domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
        domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
        theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
        b2b_theme_id = try values.decodeIfPresent(String.self, forKey: .b2b_theme_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
        domain_logo_1 = try values.decodeIfPresent(String.self, forKey: .domain_logo_1)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        test_username = try values.decodeIfPresent(String.self, forKey: .test_username)
        test_password = try values.decodeIfPresent(String.self, forKey: .test_password)
        live_username = try values.decodeIfPresent(String.self, forKey: .live_username)
        live_password = try values.decodeIfPresent(String.self, forKey: .live_password)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        whatsapp = try values.decodeIfPresent(String.self, forKey: .whatsapp)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        support_email = try values.decodeIfPresent(String.self, forKey: .support_email)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        address_ar = try values.decodeIfPresent(String.self, forKey: .address_ar)
        api_country_list_fk = try values.decodeIfPresent(String.self, forKey: .api_country_list_fk)
        api_city_list_fk = try values.decodeIfPresent(String.self, forKey: .api_city_list_fk)
        insta_url = try values.decodeIfPresent(String.self, forKey: .insta_url)
        twitter_url = try values.decodeIfPresent(String.self, forKey: .twitter_url)
        facebook_url = try values.decodeIfPresent(String.self, forKey: .facebook_url)
        linkedin_url = try values.decodeIfPresent(String.self, forKey: .linkedin_url)
        snapchat_url = try values.decodeIfPresent(String.self, forKey: .snapchat_url)
        support_url = try values.decodeIfPresent(String.self, forKey: .support_url)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
    }
    
}

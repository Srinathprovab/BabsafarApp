//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
//var data : Data?
var dateSelectKey = ""

var BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/auth/"



/* URL endpoints */
struct ApiEndpoints {
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let login = "mobile_login"
    static let register = "mobile_register_on_light_box"
    static let preflightsearchmobile = "pre_flight_search_mobile"
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    static var departon = "depart_on"
    static var returnon = "return_on"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var journeyType = "Journey_Type"
    static var origin = "Origin"
    static var destination = "Destination"
    static var cabinClass = "CabinClass"
    static var departureDate = "Departure_Date"
    
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
   
}

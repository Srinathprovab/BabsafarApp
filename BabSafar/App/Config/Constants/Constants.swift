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
var adultsArray = [String]()
var childArray = [String]()
var BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

/* URL endpoints */
struct ApiEndpoints {
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let login = "mobile_login"
    static let register = "mobile_register_on_light_box"
    static let preflightsearchmobile = "pre_flight_search_mobile"
    static let getairportcodelist = "get_airport_code_list"
    
}

/*App messages*/
struct Message {
   // static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let internetConnectionError = "no internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var dashboardTapSelected = "DashboardTapSelected"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var journeyType = "Journey_Type"
    
    
   // ONE WAY
    static var locationcity = "location_city"
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fairportCode = "fairportCode"
    static var tairportCode = "tairportCode"
    
    static var travellerDetails = "travellerDetails"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    
    
    
    //CIRCLE
    static var rlocationcity = "rlocation_city"
    static var rfromCity = "rfromCity"
    static var rtoCity = "rtoCity"
    static var rcalDepDate = "rcalDepDate"
    static var rcalRetDate = "rcalRetDate"
    static var radultCount = "rAdult_Count"
    static var rchildCount = "rChild_Count"
    static var rinfantsCount = "rInfants_Count"
    static var rselectClass = "rselect_class"
    static var rfromlocid = "rfrom_loc_id"
    static var rtolocid = "rto_loc_id"
    static var rtravellerDetails = "rtravellerDetails"
    static var rfairportCode = "rfairportCode"
    static var rtairportCode = "rtairportCode"

    

    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    
    

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

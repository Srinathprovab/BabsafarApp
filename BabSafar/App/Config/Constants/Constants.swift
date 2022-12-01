//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData



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


//MARK: - HOME SCREEN
var topHotelDetails = [TopHotelDetails]()
var topFlightDetails = [TopFlightDetails]()
var cityList:[SelectCityModel] = []
var cityLocId:[String] = []
var fd = [[FDFlightDetails]]()
var fareRulehtml = String()

var FlightList :[[J_flight_list]]?
var RTFlightList :[[RTJ_flight_list]]?
var MCJflightlist :[MCJ_flight_list]?

var countrylist = [All_country_code_list]()
var totalprice = String()
var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()


//MARK: - Multicity
var fromCityNameArray = ["Select","Select"]
var fromCityShortNameArray = ["City","City"]
var fromlocidArray = ["",""]
var toCityNameArray = ["Select","Select"]
var toCityShortNameArray = ["City","City"]
var tolocidArray = ["",""]
var depatureDatesArray = ["Select Date","Select Date"]
var fromCityArray = ["",""]
var toCityArray = ["",""]


//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var details  = [NSFetchRequestResult]()
var fnameArray = [String]()
var lnameArray = [String]()
var mnameArray = [String]()
var dobArray = [String]()
var passportNoArray = [String]()
var passportexpirydayArray = [String]()
var passportexpiryMonthArray = [String]()
var passportexpiryYearArray = [String]()
var countryCodeArray = [String]()
var passportissuingcountryArray = [String]()
var passportnationalityArray = [String]()



var dfromCityNameArray =  [String:String]()

/* URL endpoints */
struct ApiEndpoints {
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let login = "mobile_login"
    static let register = "mobile_register_on_light_box"
    static let mobileprofile = "mobile_profile"
    static let preflightsearchmobile = "pre_flight_search_mobile"
    static let getairportcodelist = "get_airport_code_list"
    static let getFlightDetails = "getFlightDetails"
    static let getTopFlightHotelDestination = "getTopFlightHotelDestination"
    static let getBaggageFlightDetails = "getFlightDetails"
    static let getCountryList = "getCountryList"
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
    static var DashboardTapSelectedCellIndex = "DashboardTapSelectedCellIndex"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var journeyType = "Journey_Type"
    static var journeyTypeSelectedIndex = "Journey_TypeSelectedIndex"
    static var searchid = "search_id"
    static var bookingsource = "booking_source"
    static var selectedResult = "selectedResult"
    static var selectdFlightcellIndex = "selectdFlightcellIndex"
    
    static var selectedCurrency = "selectedCurrency"
    static var selectedLang = "selectedLang"
    static var APICurrencyType = "APICurrencyType"
    static var APILanguageType = "APILanguageType"
    static var totalTravellerCount = "totalTravellerCount"
    
    
    
    
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
    static var select_classIndex = "select_classIndex"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromairport = "fromairport"
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
    static var rselect_classIndex = "rselect_classIndex"
    static var rfromlocid = "rfrom_loc_id"
    static var rtolocid = "rto_loc_id"
    static var rtravellerDetails = "rtravellerDetails"
    static var rfromairport = "rfromairport"
    static var rtoairport = "rtoairport"
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var travellerTitle = "travellerTitle"
    
    
    //MULTICITY TRIP
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mcalDepDate = "mcalDepDate"
    static var madultCount = "mAdult_Count"
    static var mchildCount = "mChild_Count"
    static var minfantsCount = "mInfants_Count"
    static var mselectClass = "mselect_class"
    static var mselect_classIndex = "mselect_classIndex"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mselectAirline = "mselectAirline"
    static var mtravellerDetails = "mtraveller_Details"
    static var mfromairportCode = "mfromairportCode"
    static var mfromCityValue = "mfromCityValue"
    static var mtoCityValue = "mtoCityValue"
    static var mtoairportCode = "mtoairportCode"
    static var mcaldate = "mcaldate"
    static var cellTag = "cellTag"
    static var toairport = "toairport"
    
    
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



//"placeDetails":[
//{
//"from":"Bangalore, India, Bengaluru International Airport (BLR)",
//"from_loc_id":"801",
//"to":"Dubai, UAE, Dubai International Airport (DXB)",
//"to_loc_id":"1921",
//"depature":"21-12-2022"
//}


struct MulticityArray : Codable {
    var placeDetails : [PlaceDetails]?
}


struct PlaceDetails : Codable {
    
    var from:String?
    var from_loc_id:String?
    var to:String?
    var to_loc_id:String?
    var depature:String?
    
}




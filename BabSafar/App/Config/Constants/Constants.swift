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
var BASE_URL = "https://provabdevelopment.com/pro_new/mobile/index.php/"
var BASE_URL1 = "https://provabdevelopment.com/pro_new/mobile/index.php/"

//general/
//auth/
//user/
//flight/

var deviceId = String()

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}


//MARK: - Travellers Details
var adultTravllersArray = [TravellerData]()
var childTravllersArray = [TravellerData]()
var infantaTravllersArray = [TravellerData]()
var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
var passengerA = [Passenger]()
var travelerArray: [Traveler] = []
var ageCategory: AgeCategory = .adult



//MARK: - Hotel
var hotelSearchId = String()
var roomsDetails = [[Rooms]]()
var images = [Images]()
var formatAmeArray = [Format_ame]()
var formatDesc = [Format_desc]()

var hsearchid = String()
var hbookingsource = String()
var htoken = String()
var htokenkey = String()
var selectedrRateKeyArray = String()

var adtArray = [String]()
var chArray = [String]()
var callapibool = Bool()

//MARK: - FILTER RELATED VARIABLES
var filterTap = String()
var filterPrice = String()
var prices = [String]()



//MARK: - Profile details 
var pdetails:ProfileDetails?


//MARK: - Baggage Info details 
var farerulerefkey = String()
var farerulesrefcontent = String()
var fdbool = Bool()


//MARK: - HOME SCREEN
var deailcodelist = [Deail_code_list]()
var topHotelDetails = [TopHotelDetails]()
var topFlightDetails = [TopFlightDetails]()
var cityList:[SelectCityModel] = []
var cityLocId:[String] = []
var fd = [[FDFlightDetails]]()
var jd = [JourneySummary]()
var fareRulehtml = [FareRulehtml]()

var FlightList :[[J_flight_list]]?
var RTFlightList :[[RTJ_flight_list]]?
var MCJflightlist :[MCJ_flight_list]?
var MBfd :[[MBdetails]]?
var hotelSearchResult = [HotelSearchResult]()
var mbSummery = [Summary]()
var AirlinesArray = [String]()
var ConnectingFlightsArray = [String]()
var ConnectingAirportsArray = [String]()

var bookedDate = String()
var pnrNo = String()
var bookingRefrence = String()
var bookingId = String()
var flightSelectedIndex = Int()


var countrylist = [All_country_code_list]()
var totalprice = String()
var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()

var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

var checkTermsAndCondationStatus = false

//MARK: - Multicity
var fromCityNameArray = ["Origin","Origin"]
var fromCityShortNameArray = ["Origin","Origin"]
var fromlocidArray = ["",""]
var toCityNameArray = ["Destination","Destination"]
var toCityShortNameArray = ["Destination","Destination"]
var tolocidArray = ["",""]
var depatureDatesArray = ["Date","Date"]
var fromCityArray = ["",""]
var toCityArray = ["",""]
var addmulticityCount = 0

//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var details  = [NSFetchRequestResult]()
var fnameArray = [String]()
var lnameArray = [String]()
var mnameArray = [String]()
var dobArray = [String]()
var passportNoArray = [String]()
//var passportexpirydayArray = [String]()
//var passportexpiryMonthArray = [String]()
var passportexpiryArray = [String]()
var countryCodeArray = [String]()
var passportissuingcountryArray = [String]()
var passportnationalityArray = [String]()
var title2Array = [String]()
var keyStr = String()
var dfromCityNameArray =  [String:String]()
var edit_title2_code = String()
var edit_title2 = String()
var edit_title1 = String()
var edit_fname = String()
var edit_lname = String()
var edit_email = String()
var edit_gender = String()
var edit_dob = String()
var edit_nationalitycode = String()
var edit_passportno = String()
var edit_experiesOn = String()
var edit_issuingCountrycode = String()
var edit_issuingCountryname = String()
var edit_nationalityname = String()

var loderBool = false

//Flight Paynow Screen
var payemail = String()
var paymobile = String()

/* URL endpoints */
struct ApiEndpoints {
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let login = "mobile_login"
    static let register = "mobile_register_on_light_box"
    static let mobileprofile = "mobile_profile"
    static let preflightsearchmobile = "pre_flight_search_mobile"
    static let getairportcodelist = "get_airport_code_list"
    static let getairportcodelistmulticity = "get_airport_code_list_ios"
    static let getFlightDetails = "getFlightDetails"
    static let getTopFlightHotelDestination = "getTopFlightHotelDestination"
    static let getBaggageFlightDetails = "getFlightDetails"
    static let getCountryList = "getCountryList"
    static let mobilepreprocessbooking = "mobile_pre_process_booking"
    static let mobileprocesspassengerdetail = "mobile_process_passenger_detail"
    static let mobileprebooking = "mobile_pre_booking"
    static let mobileprehotelsearch = "mobile_pre_hotel_search"
    static let gethotelcitylist = "get_hotel_city_list"
    static let mobileforgotpassword = "mobile_forgot_password"
    static let hotelmobiledetails = "mobile_details"
    static let completedbookingmobile = "completed_booking_mobile"
    static let upcomingbookingmobile = "upcoming_booking_mobile"
    static let cancelledbookingmobile = "cancelled_booking_mobile"
    static let getfarerules = "get_fare_rules"
    static let currencylist = "currency_list"
    static let visaenquiry = "visa_enquiry"
    static let contactus = "contactus"
    static let mobilelogout = "mobile_ajax_logout"
    static let mobileShowTraveller = "mobileShowTraveller"
    static let mobileDeleteTraveller = "mobileDeleteTraveller"
    static let mobileTravellerDetailsByOrigin = "mobileTravellerDetailsByOrigin"
    static let mobileUpdateTraveller = "mobileUpdateTraveller"
    static let mobileInsertTraveller = "mobileInsertTraveller"
    static let hmobilebooking = "mobile_booking"
    static let mobilehotelprebooking = "mobile_hotel_pre_booking"


    
    
}

/*App messages*/
struct Message {
    // static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let internetConnectionError = "no internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var mobilecountrycode = "mobilecountrycode"
    static var dashboardTapSelected = "DashboardTapSelected"
    static var DashboardTapSelectedCellIndex = "DashboardTapSelectedCellIndex"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var journeyType = "Journey_Type"
    static var journeyTypeSelectedIndex = "Journey_TypeSelectedIndex"
    static var searchid = "search_id"
    static var accesskey = "access_key"
    static var bookingsource = "booking_source"
    static var bookingsourcekey = "booking_source_key"
    static var selectedResult = "selectedResult"
    static var selectdFlightcellIndex = "selectdFlightcellIndex"
    static var selectedCurrency = "selectedCurrency"
    static var selectedLang = "selectedLang"
    static var APICurrencyType = "APICurrencyType"
    static var ShowAPICurrencyType = "ShowAPICurrencyType"
    static var APILanguageType = "APILanguageType"
    static var totalTravellerCount = "totalTravellerCount"
    static var traceId = "traceId"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectPersons = "selectPersons"
    
    
    // ONE WAY
    static var locationcity = "location_city"
    static var locationcityid = "location_cityid"
    static var locationcityname = "locationcityname"
    
    
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
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
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
    static var rfromcityname = "rfromcityname"
    static var rtocityname = "rtocityname"
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var travellerTitle = "travellerTitle"
    
    
    //MULTICITY TRIP
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mfromCity1 = "mfromCity1"
    static var mtoCity1 = "mtoCity1"
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
    
    
    //FILTERS SORTBY Arrival Time
    static var pricefilterbool = "pricefilterBool"
    static var pricefilterValue = "pricefilterValue"
    static var starFilter = "starFilter"
    static var starFilterValue = "starFilterValue"
    static var arrivalTime = "arrivalTime"
    static var arrivalTimeValue = "arrivalTimeValue"
    static var duration = "Duration"
    static var durationValue = "durationValue"
    
    
    
    //VISA
    static var visaadultCount = "Visa_Adult_Count"
    static var visachildCount = "Visa_Child_Count"
    static var visainfantsCount = "Visa_Infants_Count"
    static var visatravellerDetails = "Visa_Traveller_Details"
    
    
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




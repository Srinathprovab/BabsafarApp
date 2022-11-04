//
//  MC1.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MC1 : Codable {
    
    //    let airSegment_Key : String?
    //    let group : String?
    //    let carrier : String?
    //    let airline_name : String?
    let flightNumber : String?
    let origin_loc : String?
    let origin : String?
    let destination_loc : String?
    let destination : String?
    let departureTime : String?
    let arrivalTime : String?
    let flightTime : String?
    let distance : String?
    //    let eTicketability : String?
    //    let equipment : String?
    //    let changeOfPlane : String?
    //    let participantLevel : String?
    //    let availabilityDisplayType : String?
    //    let linkAvailability : String?
    //    let polledAvailabilityOption : String?
    //    let optionalServicesIndicator : String?
    //    let availabilitySource : String?
    //    let operatingCarrier : String?
    //    let operatingFlightNumber : String?
    //    let providerCode : String?
    //    let bookingCounts : String?
    //    let flightDetail_Key : String?
    //    let originTerminal : String?
    //    let destinationTerminal : String?
    //    let bookingCode : String?
    //    let cabinClass : String?
    //    let fareInfoRef : String?
    //    let farerulesref_Key : String?
    //    let farerulesref_Provider : String?
    //    let farerulesref_content : String?
    //    let baggageAllowance : String?
    //    let fareBasis : String?
    
    enum CodingKeys: String, CodingKey {
        
        //        case airSegment_Key = "AirSegment_Key"
        //        case group = "Group"
        //        case carrier = "Carrier"
        //        case airline_name = "Airline_name"
        case flightNumber = "FlightNumber"
        case origin_loc = "Origin_loc"
        case origin = "Origin"
        case destination_loc = "Destination_loc"
        case destination = "Destination"
        case departureTime = "DepartureTime"
        case arrivalTime = "ArrivalTime"
        case flightTime = "FlightTime"
        case distance = "Distance"
        //        case eTicketability = "ETicketability"
        //        case equipment = "Equipment"
        //        case changeOfPlane = "ChangeOfPlane"
        //        case participantLevel = "ParticipantLevel"
        //        case availabilityDisplayType = "AvailabilityDisplayType"
        //        case linkAvailability = "LinkAvailability"
        //        case polledAvailabilityOption = "PolledAvailabilityOption"
        //        case optionalServicesIndicator = "OptionalServicesIndicator"
        //        case availabilitySource = "AvailabilitySource"
        //        case operatingCarrier = "OperatingCarrier"
        //        case operatingFlightNumber = "OperatingFlightNumber"
        //        case providerCode = "ProviderCode"
        //        case bookingCounts = "BookingCounts"
        //        case flightDetail_Key = "FlightDetail_Key"
        //        case originTerminal = "OriginTerminal"
        //        case destinationTerminal = "DestinationTerminal"
        //        case bookingCode = "BookingCode"
        //        case cabinClass = "CabinClass"
        //        case fareInfoRef = "FareInfoRef"
        //        case farerulesref_Key = "Farerulesref_Key"
        //        case farerulesref_Provider = "Farerulesref_Provider"
        //        case farerulesref_content = "Farerulesref_content"
        //        case baggageAllowance = "BaggageAllowance"
        //        case fareBasis = "FareBasis"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        airSegment_Key = try values.decodeIfPresent(String.self, forKey: .airSegment_Key)
        //        group = try values.decodeIfPresent(String.self, forKey: .group)
        //        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        //        airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
        flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)
        origin_loc = try values.decodeIfPresent(String.self, forKey: .origin_loc)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        destination_loc = try values.decodeIfPresent(String.self, forKey: .destination_loc)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)
        arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime)
        flightTime = try values.decodeIfPresent(String.self, forKey: .flightTime)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        //        eTicketability = try values.decodeIfPresent(String.self, forKey: .eTicketability)
        //        equipment = try values.decodeIfPresent(String.self, forKey: .equipment)
        //        changeOfPlane = try values.decodeIfPresent(String.self, forKey: .changeOfPlane)
        //        participantLevel = try values.decodeIfPresent(String.self, forKey: .participantLevel)
        //        availabilityDisplayType = try values.decodeIfPresent(String.self, forKey: .availabilityDisplayType)
        //        linkAvailability = try values.decodeIfPresent(String.self, forKey: .linkAvailability)
        //        polledAvailabilityOption = try values.decodeIfPresent(String.self, forKey: .polledAvailabilityOption)
        //        optionalServicesIndicator = try values.decodeIfPresent(String.self, forKey: .optionalServicesIndicator)
        //        availabilitySource = try values.decodeIfPresent(String.self, forKey: .availabilitySource)
        //        operatingCarrier = try values.decodeIfPresent(String.self, forKey: .operatingCarrier)
        //        operatingFlightNumber = try values.decodeIfPresent(String.self, forKey: .operatingFlightNumber)
        //        providerCode = try values.decodeIfPresent(String.self, forKey: .providerCode)
        //        bookingCounts = try values.decodeIfPresent(String.self, forKey: .bookingCounts)
        //        flightDetail_Key = try values.decodeIfPresent(String.self, forKey: .flightDetail_Key)
        //        originTerminal = try values.decodeIfPresent(String.self, forKey: .originTerminal)
        //        destinationTerminal = try values.decodeIfPresent(String.self, forKey: .destinationTerminal)
        //        bookingCode = try values.decodeIfPresent(String.self, forKey: .bookingCode)
        //        cabinClass = try values.decodeIfPresent(String.self, forKey: .cabinClass)
        //        fareInfoRef = try values.decodeIfPresent(String.self, forKey: .fareInfoRef)
        //        farerulesref_Key = try values.decodeIfPresent(String.self, forKey: .farerulesref_Key)
        //        farerulesref_Provider = try values.decodeIfPresent(String.self, forKey: .farerulesref_Provider)
        //        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
        //        baggageAllowance = try values.decodeIfPresent(String.self, forKey: .baggageAllowance)
        //        fareBasis = try values.decodeIfPresent(String.self, forKey: .fareBasis)
    }
    
}

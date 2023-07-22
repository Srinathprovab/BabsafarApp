//
//  HotelMBViewModel.swift
//  BabSafar
//
//  Created by FCI on 28/03/23.
//

import Foundation


protocol HotelMBViewModelDelegate : BaseViewModelProtocol {
    func hotelMobileBookingDetails(response : HotelMBModel)
    func hotelMobilePreBookingDetails(response : HotelPreBookingModel)
    
}

class HotelMBViewModel {
    
    var view: HotelMBViewModelDelegate!
    init(_ view: HotelMBViewModelDelegate) {
        self.view = view
    }
    
    //MARK: - CALL_HOTEL_DETAILS_API
    func CALL_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.hmobilebooking)" , parameters: parms as NSDictionary, resultType: HotelMBModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelMobileBookingDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    //MARK: - CALL_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API
    func CALL_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.mobilehotelprebooking)" , parameters: parms as NSDictionary, resultType: HotelPreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelMobilePreBookingDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}

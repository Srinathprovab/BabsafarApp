//
//  TravellerViewModel.swift
//  BabSafar
//
//  Created by FCI on 24/02/23.
//

import Foundation



protocol TravellerViewModelDelegate : BaseViewModelProtocol {
    func getAdultTravellerDetails(response : ShowTravellerModel)
    func getChildTravellerDetails(response : ShowTravellerModel)
    func getInfantaTravellerDetails(response : ShowTravellerModel)
}

class TravellerViewModel {
    
    var view: TravellerViewModelDelegate!
    init(_ view: TravellerViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_ADULT_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileShowTraveller)" , parameters: parms, resultType: ShowTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getAdultTravellerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_CHILD_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileShowTraveller)" , parameters: parms, resultType: ShowTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getChildTravellerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_INFANTA_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileShowTraveller)" , parameters: parms, resultType: ShowTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getInfantaTravellerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}

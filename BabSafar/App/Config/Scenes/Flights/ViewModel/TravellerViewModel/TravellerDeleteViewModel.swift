//
//  TravellerDeleteViewModel.swift
//  BabSafar
//
//  Created by FCI on 26/02/23.
//

import Foundation


protocol TravellerDeleteViewModelDelegate : BaseViewModelProtocol {
    func travellerDeletedSucess(response : AddTravellerModel)
    
}

class TravellerDeleteViewModel {
    
    var view: TravellerDeleteViewModelDelegate!
    init(_ view: TravellerDeleteViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_DELETE_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileDeleteTraveller)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: AddTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.travellerDeletedSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}


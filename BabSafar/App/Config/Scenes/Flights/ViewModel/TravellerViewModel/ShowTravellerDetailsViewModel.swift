//
//  ShowTravellerDetailsViewModel.swift
//  BabSafar
//
//  Created by FCI on 26/02/23.
//

import Foundation

protocol ShowTravellerDetailsViewModelDelegate : BaseViewModelProtocol {
    func travellerDetails(response : ShowTravellerByOriginModel)
    
}

class ShowTravellerDetailsViewModel {
    
    var view: ShowTravellerDetailsViewModelDelegate!
    init(_ view: ShowTravellerDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_SHOW_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileTravellerDetailsByOrigin)", parameters: parms, resultType: ShowTravellerByOriginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.travellerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}

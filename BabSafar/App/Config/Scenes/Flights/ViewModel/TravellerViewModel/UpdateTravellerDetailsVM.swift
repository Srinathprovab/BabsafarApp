//
//  UpdateTravellerDetailsVM.swift
//  BabSafar
//
//  Created by FCI on 26/02/23.
//

import Foundation



protocol UpdateTravellerDetailsVMDelegate : BaseViewModelProtocol {
    func updetedTravellerDetails(response : AddTravellerModel)
    func addTraverllerDetails(response : AddTravellerModel)
}

class UpdateTravellerDetailsVM {
    
    var view: UpdateTravellerDetailsVMDelegate!
    init(_ view: UpdateTravellerDetailsVMDelegate) {
        self.view = view
    }
    
    
    func CALL_UPDATE_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileUpdateTraveller)", parameters: parms, resultType: AddTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.updetedTravellerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_ADD_TRAVELLER_DETAILS(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileInsertTraveller)", parameters: parms, resultType: AddTravellerModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.addTraverllerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}

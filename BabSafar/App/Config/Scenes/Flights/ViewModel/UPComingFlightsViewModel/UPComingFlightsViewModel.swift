//
//  UPComingFlightsViewModel.swift
//  BabSafar
//
//  Created by FCI on 14/02/23.
//

import Foundation


protocol UPComingFlightsViewModelDelegate : BaseViewModelProtocol {
    
    func upcomingFlightsDetails(response:UPComingFlightsModel)
    func cancelledFlightsDetails(response:UPComingFlightsModel)
    func completedFlightsDetails(response:UPComingFlightsModel)
    
    
}

class UPComingFlightsViewModel {
    
    var view: UPComingFlightsViewModelDelegate!
    init(_ view: UPComingFlightsViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_UPCOMING_MOBIL_BOOKING API
    func CALL_UPCOMING_MOBIL_BOOKING(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.upcomingbookingmobile)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: UPComingFlightsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.upcomingFlightsDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_CANCELLED_MOBIL_BOOKING API
    func CALL_CANCELLED_MOBIL_BOOKING(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.cancelledbookingmobile)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: UPComingFlightsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cancelledFlightsDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK:  CALL_COMPLETED_MOBIL_BOOKING API
    func CALL_COMPLETED_MOBIL_BOOKING(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.completedbookingmobile)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: UPComingFlightsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.completedFlightsDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}

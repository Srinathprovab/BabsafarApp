//
//  HotelSearchViewModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation



protocol HotelSearchViewModelDelegate : BaseViewModelProtocol {
    func activebookingSourceResult(response : ActiveBookingSourceModel)
    func hoteSearchPreResult(response : HotelSearchNewModel)
    func hoteSearchResult(response : HotelSearchModel)
    func hoteSearchPagenationResult(response : HotelSearchModel)
}

class HotelSearchViewModel {
    
    var view: HotelSearchViewModelDelegate!
    init(_ view: HotelSearchViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_GET_ACTIVE_BOOKING_SOURCE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_getActiveBookingSource,parameters: parms as NSDictionary, resultType: ActiveBookingSourceModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.activebookingSourceResult(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CallHotelPreSearchAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobileprehotelsearch)",urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: HotelSearchNewModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hoteSearchPreResult(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CallHotelSearchAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobileHotelSearch,urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: HotelSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hoteSearchResult(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CallHotelSearchPagenationAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //     self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.ajaxHotelSearch_pagination)",urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: HotelSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hoteSearchPagenationResult(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}

//
//  HotelCitySearchViewModel.swift
//  BabSafar
//
//  Created by FCI on 28/12/22.
//

import Foundation






protocol HotelCitySearchViewModelDelegate : BaseViewModelProtocol {
    func hotelCitySearchResult(response : [HotelCityListModel])
}

class HotelCitySearchViewModel {
    
    var view: HotelCitySearchViewModelDelegate!
    init(_ view: HotelCitySearchViewModelDelegate) {
        self.view = view
    }
    
    
    func CallHotelCitySearchAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
    //    self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "ajax/\(ApiEndpoints.gethotelcitylist)",urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: [HotelCityListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
           //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelCitySearchResult(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}

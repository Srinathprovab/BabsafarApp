//
//  FlightDetailsViewModel.swift
//  BabSafar
//
//  Created by FCI on 10/10/22.
//

import Foundation
import Alamofire


protocol FlightDetailsViewModelProtocal : BaseViewModelProtocol {
    func flightDetails(response : FlightDetailsModel)
}

class FlightDetailsViewModel {

    var view: FlightDetailsViewModelProtocal!
    init(_ view: FlightDetailsViewModelProtocal) {
        self.view = view
    }


    func getFlightDetails(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getFlightDetails , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: FlightDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightDetails(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}

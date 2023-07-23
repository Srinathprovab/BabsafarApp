//
//  FDViewModel.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//


import Foundation

protocol FDViewModelDelegate : BaseViewModelProtocol {
    func flightDetails(response : FDModel)
}

class FDViewModel {

    var view: FDViewModelDelegate!
    init(_ view: FDViewModelDelegate) {
        self.view = view
    }


    func CALL_GET_FLIGHT_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.getBaggageFlightDetails)" , parameters: parms, resultType: FDModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
              //  self.view?.hideLoader()
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

import Foundation
import Alamofire


protocol FlightListModelProtocal : BaseViewModelProtocol {
    func flightList(response : FlightSearchModel)
  //  func roundTripflightList(response : RoundTripModel)
    func multiTripflightList(response : MulticityModel)

    
}

class FlightListViewModel {

    var view: FlightListModelProtocal!
    init(_ view: FlightListModelProtocal) {
        self.view = view
    }


    func CallSearchFlightAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilePreFlightSearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: FlightSearchModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
//    func CallRoundTRipSearchFlightAPI(dictParam: [String: Any]){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilePreFlightSearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: RoundTripModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.roundTripflightList(response: response)
//                } else {
//
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
    
    
    
    
    
    func CallMulticityTripSearchFlightAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilePreFlightSearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: MulticityModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.multiTripflightList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }


}

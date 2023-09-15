//
//  PaymentGatewayVC.swift
//  BabSafar
//
//  Created by FCI on 01/08/23.
//

import UIKit
import MFSDK


class PaymentGatewayVC: UIViewController, updatePaymentFlightViewModelDelegate {
   
    
    
    //MARK: Variables
    var paymentMethods: [MFPaymentMethod]?
    var selectedPaymentMethodIndex: Int?
    var payload = [String:Any]()
    var grandTotalamount: String?
    var grand_total_Price: String?
    var invoiceValue = Double()
    var tmpFlightPreBookingId = String()
    var pgstatus = "Succss"
    var vm:updatePaymentFlightViewModel?
    var paymentResponse = String()
    var form_url_paymentSucess = ""
    var searchid = ""
    //MARK: Outlet
    //    @IBOutlet weak var errorCodeLabel : UILabel!
    @IBOutlet weak var payButton: UIButton!
    //    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var cardInfoStackViews: [UIStackView]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var secureCodeTextField: UITextField!
    
    @IBOutlet weak var kwdpricelbl: UILabel!
    
    
    
    static var newInstance: PaymentGatewayVC? {
        let storyboard = UIStoryboard(name: Storyboard.PaymentGateway.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PaymentGatewayVC
        return vc
    }
    
    //at list one product Required
    let productList = NSMutableArray()
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.isEnabled = false
        
       // kwdpricelbl.text = grandTotalamount
        invoiceValue = Double(grand_total_Price ?? "0.0") ?? 0.0
        
        setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                             str2: "\(grand_total_Price ?? "")",
                             lbl: kwdpricelbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .WhiteColor,
                             str2Color: .WhiteColor)
        
        
        setCardInfo()
        initiatePayment()
        vm = updatePaymentFlightViewModel(self)
        
        
        // set delegate
        MFSettings.shared.delegate = self
    }
    
    
    @IBAction func payDidPRessed(_ sender: Any) {
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            if let selectedIndex = selectedPaymentMethodIndex {
                
                executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                
                //                if paymentMethods[selectedIndex].paymentMethodCode == MFPaymentMethodCode.applePay.rawValue {
                //                    // executeApplePayPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                //                } else if paymentMethods[selectedIndex].isDirectPayment {
                //                    // executeDirectPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                //                } else {
                //                   // executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                //                }
            }
        }
    }
    
    
    //    @IBAction func sendPaymentDidTapped(_ sender: Any) {
    //        sendPayment()
    //    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        BASE_URL = BASE_URL1
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
}

extension PaymentGatewayVC  {
    func startSendPaymentLoading() {
        //        errorCodeLabel.text = "Status:"
        //        resultTextView.text = "Result:"
        //        sendPaymentButton.setTitle("", for: .normal)
        //        sendPaymentActivityIndicator.startAnimating()
    }
    //    func stopSendPaymentLoading() {
    //       PaymentButton.setTitle("Send Payment", for: .normal)
    //        send
    //        sendPaymentActivityIndicator.stopAnimating()
    //    }
    func startLoading() {
        //        errorCodeLabel.text = "Status:"
        //        resultTextView.text = "Result:"
        payButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }
    func stopLoading() {
        // payButton.setTitle("Pay", for: .normal)
        activityIndicator.stopAnimating()
    }
    
    
    func showSuccess(_ message: String) {
        //        errorCodeLabel.text = "Succes"
        //        resultTextView.text = "result: \(message)"
    }
    
    func showFailError(_ error: MFFailResponse) {
        //        errorCodeLabel.text = "responseCode: \(error.statusCode)"
        //        resultTextView.text = "Error: \(error.errorDescription)"
    }
}
extension PaymentGatewayVC {
    func hideCardInfoStacksView(isHidden: Bool) {
        for stackView in cardInfoStackViews {
            stackView.isHidden = isHidden
        }
    }
    private func setCardInfo() {
        cardNumberTextField.placeholder = "5123450000000008"
        cardHolderNameTextField.placeholder = "John Wick"
        monthTextField.placeholder = "05"
        yearTextField.placeholder = "21"
        secureCodeTextField.placeholder = "100"
    }
}



extension PaymentGatewayVC: MFPaymentDelegate {
    
    func didInvoiceCreated(invoiceId: String) {
        print("#Invoice id:", invoiceId)
    }
    
    
}



extension PaymentGatewayVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            //callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}

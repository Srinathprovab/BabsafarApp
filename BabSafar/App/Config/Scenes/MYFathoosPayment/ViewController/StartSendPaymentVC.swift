//
//  StartSendPaymentVC.swift
//  BabSafar
//
//  Created by FCI on 27/06/23.
//

import UIKit
import MFSDK


class StartSendPaymentVC: UIViewController {
    
    
    static var newInstance: StartSendPaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Payment.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? StartSendPaymentVC
        return vc
    }
    
    //MARK: Variables
    var paymentMethods: [MFPaymentMethod]?
    var selectedPaymentMethodIndex: Int?
    
    
    //MARK: Outlet
    @IBOutlet weak var errorCodeLabel : UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var cardInfoStackViews: [UIStackView]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var secureCodeTextField: UITextField!
    @IBOutlet weak var sendPaymentButton: UIButton!
    @IBOutlet weak var sendPaymentActivityIndicator: UIActivityIndicatorView!
    
    
    //at list one product Required
    let productList = NSMutableArray()
    var grandTotalamount = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        amountTextField.isUserInteractionEnabled = false
        amountTextField.text = grandTotalamount
        payButton.isEnabled = false
        
        setCardInfo()
        initiatePayment()
        
       
        // set delegate
        MFSettings.shared.delegate = self
        
        
    }
    
    @IBAction func payDidPRessed(_ sender: Any) {
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            if let selectedIndex = selectedPaymentMethodIndex {
                
                if paymentMethods[selectedIndex].paymentMethodCode == MFPaymentMethodCode.applePay.rawValue {
                   // executeApplePayPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                } else if paymentMethods[selectedIndex].isDirectPayment {
                   // executeDirectPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                } else {
                    executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                }
            }
        }
    }
    @IBAction func sendPaymentDidTapped(_ sender: Any) {
        sendPayment()
    }
}





extension StartSendPaymentVC {
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




extension StartSendPaymentVC: MFPaymentDelegate {
    func didInvoiceCreated(invoiceId: String) {
        print("#Invoice id:", invoiceId)
    }
}



extension StartSendPaymentVC {
    //1===
    func initiatePayment() {
        let request = generateInitiatePaymentModel()
        startLoading()
        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
            self?.stopLoading()
            switch result {
            case .success(let initiatePaymentResponse):
                self?.paymentMethods = initiatePaymentResponse.paymentMethods
                self?.collectionView.reloadData()
            case .failure(let failError):
                self?.showFailError(failError)
            }
        })
    }
    
    
    
    private func generateInitiatePaymentModel() -> MFInitiatePaymentRequest {
        // you can create initiate payment request with invoice value and currency
        // let invoiceValue = Double(amountTextField.text ?? "") ?? 0
        // let request = MFInitiatePaymentRequest(invoiceAmount: invoiceValue, currencyIso: .kuwait_KWD)
        // return request
        
        let request = MFInitiatePaymentRequest()
        return request
    }
    
    
    func executePayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        startLoading()
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .arabic) { [weak self] response, invoiceId  in
            self?.stopLoading()
            switch response {
            case .success(let executePaymentResponse):
                if let invoiceStatus = executePaymentResponse.invoiceStatus {
                    self?.showSuccess(invoiceStatus)
                }
            case .failure(let failError):
                self?.showFailError(failError)
            }
        }
    }
    
    
    private func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
        let invoiceValue = Decimal(string: amountTextField.text ?? "0") ?? 0
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue , paymentMethod: paymentMethodId)
        //request.userDefinedField = ""
        request.customerEmail = payemail// must be email
        request.customerMobile = paymobile
        request.customerCivilId = "1234567890"
        request.customerName = "Test MyFatoorah"
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerReference = "Test MyFatoorah Reference"
        request.language = .english
        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
        request.displayCurrencyIso = .kuwait_KWD
        //        request.recurringModel = MFRecurringModel(recurringType: .weekly, iteration: 2)
        //        request.supplierValue = 1
        //        request.supplierCode = 2
        //        request.suppliers.append(MFSupplier(supplierCode: 1, proposedShare: 2, invoiceShare: invoiceValue))
        
        // Uncomment this to add products for your invoice
        //         var productList = [MFProduct]()
        //        let product = MFProduct(name: "ABC", unitPrice: 1.887, quantity: 1)
        //         productList.append(product)
        //         request.invoiceItems = productList
        return request
    }
    
}




extension StartSendPaymentVC  {
    func startSendPaymentLoading() {
        errorCodeLabel.text = "Status:"
        resultTextView.text = "Result:"
        sendPaymentButton.setTitle("", for: .normal)
        sendPaymentActivityIndicator.startAnimating()
    }
    func stopSendPaymentLoading() {
        sendPaymentButton.setTitle("Send Payment", for: .normal)
        sendPaymentActivityIndicator.stopAnimating()
    }
    func startLoading() {
        errorCodeLabel.text = "Status:"
        resultTextView.text = "Result:"
        payButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }
    func stopLoading() {
        payButton.setTitle("Pay", for: .normal)
        activityIndicator.stopAnimating()
    }
    func showSuccess(_ message: String) {
        errorCodeLabel.text = "Succes"
        resultTextView.text = "result: \(message)"
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            guard let vc = BookingConfirmedVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            callapibool = true
            //  present(vc, animated: true)
        }
        
    }
    
    func showFailError(_ error: MFFailResponse) {
        errorCodeLabel.text = "responseCode: \(error.statusCode)"
        resultTextView.text = "Error: \(error.errorDescription)"
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            callapibool = true
            present(vc, animated: true)
        }
        
    }
}

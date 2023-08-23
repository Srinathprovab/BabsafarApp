//
//  PaymentGatewayVC.swift
//  BabSafar
//
//  Created by FCI on 01/08/23.
//

import UIKit
import MFSDK


class PaymentGatewayVC: UIViewController {
    
    
    //MARK: Variables
    var paymentMethods: [MFPaymentMethod]?
    var selectedPaymentMethodIndex: Int?
    var payload = [String:Any]()
    var grandTotalamount: String?
    var grand_total_Price: String?
    
  
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
    
    
    static var newInstance: PaymentGatewayVC? {
        let storyboard = UIStoryboard(name: Storyboard.PaymentGateway.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PaymentGatewayVC
        return vc
    }
    
    //at list one product Required
    let productList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.isEnabled = false
        
        self.amountTextField.text = "100"
        
        setCardInfo()
        initiatePayment()
        
        
        // set delegate
        MFSettings.shared.delegate = self
    }
    
    
    @IBAction func payDidPRessed(_ sender: Any) {
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            if let selectedIndex = selectedPaymentMethodIndex {
                
                if paymentMethods[selectedIndex].paymentMethodCode == MFPaymentMethodCode.applePay.rawValue {
                    executeApplePayPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
                } else if paymentMethods[selectedIndex].isDirectPayment {
                    executeDirectPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
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

extension PaymentGatewayVC  {
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
    }
    
    func showFailError(_ error: MFFailResponse) {
        errorCodeLabel.text = "responseCode: \(error.statusCode)"
        resultTextView.text = "Error: \(error.errorDescription)"
    }
}
extension PaymentGatewayVC {
    func hideCardInfoStacksView(isHidden: Bool) {
        for stackView in cardInfoStackViews {
            stackView.isHidden = isHidden
        }
    }
    private func setCardInfo() {
        cardNumberTextField.text = "5123450000000008"
        cardHolderNameTextField.text = "John Wick"
        monthTextField.text = "05"
        yearTextField.text = "21"
        secureCodeTextField.text = "100"
    }
}



extension PaymentGatewayVC: MFPaymentDelegate {
    func didInvoiceCreated(invoiceId: String) {
        print("#Invoice id:", invoiceId)
    }
}

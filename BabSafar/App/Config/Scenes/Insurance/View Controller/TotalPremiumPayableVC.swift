//
//  TotalPremiumPayableVC.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class TotalPremiumPayableVC: BaseTableVC, InsurancePreprocessBookingViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    
    var price = String()
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var vm:InsurancePreprocessBookingViewModel?
    static var newInstance: TotalPremiumPayableVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TotalPremiumPayableVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = InsurancePreprocessBookingViewModel(self)
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        holderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        
        commonTableView.registerTVCells(["TotalPremiumPayableTVCell",
                                         "EmptyTVCell"])
        commonTableView.isScrollEnabled = false
        
    }
    
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:price,cellType:.TotalPremiumPayableTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    override func didTapOnCloseBtnAction(cell: TotalPremiumPayableTVCell) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnNextButtonAction(_ sender: Any) {
        gotoPersonalDetailsVC()
    }
    
    
    func gotoPersonalDetailsVC() {
        guard let vc = PersonalDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
}



extension TotalPremiumPayableVC {
    
    func callAPI() {
        payload["search_id"] = isearchid
        payload["plan_code"] = iplancode
        payload["booking_source"] = ibookingsource
        payload["plan_details"] = iplandetails
        
        vm?.CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: payload)
    }
    
    func insurencePaymentshow(response: InsurancePreprocessBookingModel) {
        holderView.isHidden = false
        price = "\(response.currencyCode ?? ""):\(response.total_fare?.rounded() ?? 0.0)"
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
}



extension TotalPremiumPayableVC {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            setupTV()
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

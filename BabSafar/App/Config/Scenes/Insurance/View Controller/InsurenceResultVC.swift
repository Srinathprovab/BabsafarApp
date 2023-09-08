//
//  InsurenceResultVC.swift
//  BabSafar
//
//  Created by FCI on 22/08/23.
//

import UIKit

class InsurenceResultVC:UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var insurenceListTV: UITableView!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    
    
    var expandedIndexPath: IndexPath?
    var availablePlans = [[AvailablePlans]]()
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var vm:InsurenceViewModel?
    static var newInstance: InsurenceResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsurenceResultVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        if callapibool == true {
            holderView.isHidden = true
            self.callAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = InsurenceViewModel(self)
    }
    
    
    
    
    func setupUI() {
        
    }
    
    @IBAction func didTapOnBackBtn(_ sender: Any) {
        guard let vc = InsuranceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func didTapOnEditSearchBtn(_ sender: Any) {
        guard let vc = ModifyInsuranceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
}


extension InsurenceResultVC:InsurenceViewModelDelegate, UITableViewDelegate,UITableViewDataSource,InsurenceResultTVCellDelegate {
    
    
    func didTapOnKeyBenifitsBtnAction(cell: InsurenceResultTVCell) {
        
        selectedPlanContent = cell.planContent
        gotoShowPlanContentVC()
        //        if let indexPath = insurenceListTV.indexPath(for: cell) {
        //            insurenceListTV.reloadRows(at: [indexPath], with: .automatic)
        //        }
    }
    
    
    func gotoShowPlanContentVC() {
        guard let vc = ShowPlanContentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    func callAPI() {
        vm?.CALL_MOBILE_INSURENCE_SEARCH_API(dictParam: payload)
    }
    
    func insurenceList(response: InsurenceModel) {
        
        if response.status == 1 {
            holderView.isHidden = false
            citylbl.text = "\(response.data?.col_x?.search_params?.from_loc_country ?? "")(\(response.data?.col_x?.search_params?.from_loc ?? "")) - \(response.data?.col_x?.search_params?.to_loc_country ?? "")(\(response.data?.col_x?.search_params?.to_loc ?? ""))"
            
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                if journeyType == "oneway" {
                    datelbl.text = "\(response.data?.col_x?.search_params?.depature ?? "") | \(response.data?.col_x?.search_params?.adult_config ?? "") Adults,\(response.data?.col_x?.search_params?.child_config ?? "") Child,\(response.data?.col_x?.search_params?.infant_config ?? "") Infant"
                    
                    
                }else{
                    datelbl.text = "\(response.data?.col_x?.search_params?.depature ?? "") to \(response.data?.col_x?.search_params?.arrival ?? "") | \(response.data?.col_x?.search_params?.adult_config ?? "") Adults,\(response.data?.col_x?.search_params?.child_config ?? "") Child,\(response.data?.col_x?.search_params?.infant_config ?? "") Infant"
                    
                }
            }
            
            availablePlans = response.data?.col_x?.list?.availablePlans ?? [[]]
            ibookingsource = response.data?.col_x?.booking_source_key ?? ""
            isearchid = "\(response.data?.col_x?.search_id ?? 0)"
            itotalPax = "\(response.data?.col_x?.search_params?.total_pax ?? 0)"
            
            DispatchQueue.main.async {
                self.setupTV()
            }
            
            
        }else {
            resultnil()
        }
    }
    
    
    func setupTV() {
        let nib = UINib(nibName: "InsurenceResultTVCell", bundle: nil)
        insurenceListTV.register(nib, forCellReuseIdentifier: "cell")
        insurenceListTV.delegate = self
        insurenceListTV.dataSource = self
        insurenceListTV.tableFooterView = UIView()
        insurenceListTV.separatorStyle = .none
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return availablePlans.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availablePlans[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InsurenceResultTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            if indexPath.section < availablePlans.count && indexPath.row < availablePlans[indexPath.section].count {
                
                let section = indexPath.section
                let row = indexPath.row
                cell.row = indexPath.row
                cell.indexvalue = indexPath.section
                
                let data = availablePlans[section][row]
                cell.titlelbl.text = data.planTitle ?? ""
                cell.pricelbl.text = "\(data.currency ?? ""):\(data.price?.total_fare_api ?? "0.0")"
                cell.logo.sd_setImage(with: URL(string: data.plan_image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.plancode = data.planCode ?? ""
                cell.plandetails = data.plan_details_token ?? ""
                cell.planContent = data.planContent ?? []
                
                
                // Check if the current indexPath is the one that should be expanded
//                if indexPath == expandedIndexPath {
//                    cell.isExpanded = true
//                    cell.show()
//                } else {
//                    cell.isExpanded = false
//                    cell.hide()
//                }
                
                
            } else {
                print("Index out of range error: indexPath = \(indexPath)")
            }
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    func didTapOnSelectInsurenceBtnAction(cell: InsurenceResultTVCell) {
        selectedPlanContent.removeAll()
        
        iplanTitle = cell.titlelbl.text ?? ""
        iplancode = cell.plancode
        iplandetails = cell.plandetails
        iplanprice = cell.pricelbl.text ?? ""
        selectedPlanContent = cell.planContent
        gotoTotalPremiumPayableVC()
    }
    
    func gotoTotalPremiumPayableVC(){
        guard let vc = TotalPremiumPayableVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
}



extension InsurenceResultVC {
    
    func addObserver() {
        loderBool = false
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

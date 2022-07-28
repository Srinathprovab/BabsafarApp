//
//  TravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class TravellerDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    static var newInstance: TravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    
    func setupUI() {
        navBar.titlelbl.text = ""
        navBar.view.isHidden = false
        navBar.airwaysTitlelbl.text = "Qatar Airways"
        
        navBar.sourceTimelbl.text = "05:50"
        navBar.sourceCitylbl.text = "Dubai (dXB)"
        navBar.destTimelbl.text = "07:15"
        navBar.destCitylbl.text = "Kuwait (KWI)"
        navBar.hourslbl.text = "1h 40mis"
        navBar.hourslbl.addBottomBorderWithColor(color: .AppCalenderDateSelectColor, width: 1)
        navBar.noOfStopslbl.text = "1 stop"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
    }
    
    func setupTV() {
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TDetailsLoginTVCell","EmptyTVCell","ContactInformationTVCell","TravelInsuranceTVCell","PriceSummaryTVCell","AddTravellerTVCell"])
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        tablerow.append(TableRow(cellType:.AddTravellerTVCell))
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.TravelInsuranceTVCell))
        tablerow.append(TableRow(cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppBorderColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
    }
    
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        print("didTapOnCountryCodeBtn")
    }
    
    override func editingTextField(tf:UITextField){
        print(tf.tag)
    }
    
    override func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {
        print("didTapOnInsureSkipButton")
    }
    
    override func didTapOnPABtn(cell: TravelInsuranceTVCell) {
        print("didTapOnPABtn")
    }
    
    override func didTapOnTCBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTCBtn")
    }
    
    override func didTapOnTDBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTDBtn")
    }
    
    override func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTC1Btn")
    }
    
    override func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTD1Btn")
    }
    
    var showMoreBool = true
    override func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {
        if showMoreBool == true {
            cell.showMorelbl.text = "- Show Less"
            cell.optionView.isHidden = false
            cell.optionViewHeight.constant = 100
            showMoreBool = false
        }else {
            cell.showMorelbl.text = "+ Show More"
            cell.optionView.isHidden = true
            cell.optionViewHeight.constant = 0
            showMoreBool = true
        }
        
    }
    
    
    override func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioSelected")
        cell.radioImg2.image = UIImage(named: "radioUnselected")
    }
    
    override func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioUnselected")
        cell.radioImg2.image = UIImage(named: "radioSelected")
    }
    
    override func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRemoveTravelInsuranceBtn")
    }
    
    @objc func didTapOnKWDBtn(_ sender: UIButton) {
        print("didTapOnKWDBtn")
    }
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    var height = 190
    override func didTapOnAddAdultBtn(cell: AddTravellerTVCell) {
        print("didTapOnAddAdultBtn")
        
        height = 10 + height
       // cell.adultTVHeight.constant = CGFloat(height)
        
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func didTapOnAddChildBtn(cell: AddTravellerTVCell) {
        print("didTapOnAddChildBtn")
    }
    
}


extension TravellerDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.kwdBtn.addTarget(self, action: #selector(didTapOnKWDBtn(_:)), for: .touchUpInside)
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

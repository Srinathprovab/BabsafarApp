//
//  SearchHotelsResultVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class SearchHotelsResultVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navView: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: SearchHotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsResultVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        navView.titlelbl.text = ""
        navView.filterBtnView.isHidden = false
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.titlelbl.text = ""
        navView.filterBtn.addTarget(self, action: #selector(didTapOnFilterBtn(_:)), for: .touchUpInside)
        navView.editBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        navView.lbl1.text = "dubai (DXB) - kuwait (kWI)"
        navView.lbl2.text = "26 jul - 27 jul | 26 jul - 27 jul"
        navView.editBtnView.isHidden = false
        navView.filterBtnView.isHidden = false
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        commonTableView.registerTVCells(["ButtonTVCell","SearchLocationTFTVCell","EmptyTVCell","HotelsTVCell"])
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
     //   tablerow.append(TableRow(cellType:.SearchLocationTFTVCell))
        
        tablerow.append(TableRow(cellType:.HotelsTVCell))
        tablerow.append(TableRow(cellType:.HotelsTVCell))
        tablerow.append(TableRow(cellType:.HotelsTVCell))
        tablerow.append(TableRow(cellType:.HotelsTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    @objc func didTapOnFilterBtn(_ sender:UIButton){
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func didTapOnEditBtn(_ sender:UIButton){
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "flights" {
                guard let vc = SearchFlightsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
            }else {
                guard let vc = ModifySearchHotelVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
            }
        }
        
        
    }
    
    override func viewBtnAction(cell: CommonFromCityTVCell) {
        print(cell.subtitlelbl.text as Any)
    }
    
    override func didTapOnDual1Btn(cell:CommonFromCityTVCell){
        print(cell.dual1lbl2.text)
    }
    override func didTapOnDual2Btn(cell:CommonFromCityTVCell){
        print(cell.dual2lbl2.text)
    }
    
    
    override func editingTextField(tf: UITextField) {
        print(tf.text)
    }
    
    
    override func mapViewBtnAction(cell:SearchLocationTFTVCell){
        print("mapViewBtnAction ..")
    }
    
    
    override func didTapOnRefundableBtn(cell: HotelsTVCell) {
        print("didTapOnRefundableBtn")
    }
    
    func goToHotelDetailsVC() {
        guard let vc = HotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
}


extension SearchHotelsResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToHotelDetailsVC()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationTFTVCell") as! SearchLocationTFTVCell
        headerCell.delegate = self
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

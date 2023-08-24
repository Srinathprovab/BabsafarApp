//
//  InsurenceSearchTVCell.swift
//  BabSafar
//
//  Created by FCI on 22/08/23.
//

import UIKit


protocol InsurenceSearchTVCellDelegate {
    func didTapOnDepartureDateBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnReturnDateBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnAddPassengersBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnSearchInsurenceBtnAction(cell:InsurenceSearchTVCell)
}

class InsurenceSearchTVCell: TableViewCell, FastrackAirlineListViewModelDelegate {
    
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var depDateView: UIView!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var addPassengerView: UIView!
    @IBOutlet weak var passengerlbl: UILabel!
    @IBOutlet weak var fromCityTV: UITableView!
    @IBOutlet weak var fromCityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var toCityTV: UITableView!
    @IBOutlet weak var toCityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    
    var airlineList = [FastrackAirlineListModel]()
    var cityViewModel: SelectCityViewModel?
    var airlineViewModel: FastrackAirlineListViewModel?
    var payload = [String:Any]()
    var txtbool = true
    var delegate:InsurenceSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        airlineViewModel = FastrackAirlineListViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if journeyType == "Insurence" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                    if journeyType == "oneway" {
                        returnView.isHidden = true
                        fromTF.text = defaults.string(forKey: UserDefaultsKeys.ifromCity) ?? ""
                        toTF.text = defaults.string(forKey: UserDefaultsKeys.itoCity) ?? ""
                        depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.icalDepDate) ?? "+ Add Date"
                        passengerlbl.text = defaults.string(forKey: UserDefaultsKeys.itravellerDetails) ?? ""
                    }else {
                        returnView.isHidden = false
                        fromTF.text = defaults.string(forKey: UserDefaultsKeys.irfromCity) ?? ""
                        toTF.text = defaults.string(forKey: UserDefaultsKeys.irtoCity) ?? ""
                        depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.ircalDepDate) ?? "+ Add Date"
                        returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.ircalRetDate) ?? "+ Add Date"
                        passengerlbl.text = defaults.string(forKey: UserDefaultsKeys.irtravellerDetails) ?? ""
                    }
                }
                
                
                setupTV()
                fromCityTVHeight.constant = 0
                toCityTVHeight.constant = 0
                CallShowCityListAPI(str: "")
                
            }else {
                
                returnView.isHidden = false
                fromTF.text = defaults.string(forKey: UserDefaultsKeys.frfromCity) ?? ""
                toTF.text = defaults.string(forKey: UserDefaultsKeys.frtoCity) ?? ""
                depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.frcalDepDate) ?? "+ Add Date"
                returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.frcalRetDate) ?? "+ Add Date"
                passengerlbl.text = defaults.string(forKey: UserDefaultsKeys.frtravellerDetails) ?? ""
                
                
                setupTV()
                fromCityTVHeight.constant = 0
                toCityTVHeight.constant = 0
                self.CALL_GET_AIRLINE_LIST_API(str: "")
            }
        }
        
    }
    
    
    func setupUI() {
        returnView.isHidden = true
        setupView(v: fromView)
        setupView(v: toView)
        setupView(v: depDateView)
        setupView(v: returnView)
        setupView(v: addPassengerView)
        setupView(v: searchView)
        setupTextField(tf: fromTF)
        setupTextField(tf: toTF)
    }
    
    func setupView(v:UIView){
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    func setupTextField(tf:UITextField) {
        tf.tag = 1
        tf.textColor = .AppLabelColor
        tf.font = .LatoSemibold(size: 16)
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        tf.setLeftPaddingPoints(2)
    }
    
    
    
    @IBAction func didTapOnClearFromTfBtnAction(_ sender: Any) {
        fromTF.text = ""
    }
    
    
    @IBAction func didTapOnClearToTFBtnAction(_ sender: Any) {
        toTF.text = ""
    }
    
    
    @IBAction func didTapOnDepartureDateBtnAction(_ sender: Any) {
        delegate?.didTapOnDepartureDateBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnReturnDateBtnAction(_ sender: Any) {
        delegate?.didTapOnReturnDateBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddPassengersBtnAction(_ sender: Any) {
        delegate?.didTapOnAddPassengersBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSearchInsurenceBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchInsurenceBtnAction(cell: self)
    }
    
    
    
}


extension InsurenceSearchTVCell:SelectCityViewModelProtocal {
    
    func ShowCityListMulticity(response: [SelectCityModel]) {
        
    }
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
    
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if journeyType == "Insurence" {
                if textField == fromTF {
                    txtbool = true
                    if textField.text?.isEmpty == true {
                        
                    }else {
                        CallShowCityListAPI(str: textField.text ?? "")
                        
                    }
                }else {
                    txtbool = false
                    if textField.text?.isEmpty == true {
                        
                    }else {
                        CallShowCityListAPI(str: textField.text ?? "")
                    }
                }
            }else {
                
                
                if textField == fromTF {
                    txtbool = true
                    if textField.text?.isEmpty == true {
                        
                    }else {
                        CALL_GET_AIRLINE_LIST_API(str: textField.text ?? "")
                    }
                }else {
                    txtbool = false
                    if textField.text?.isEmpty == true {
                        
                    }else {
                        CALL_GET_AIRLINE_LIST_API(str: textField.text ?? "")
                    }
                }
            }
        }
        
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if journeyType == "Insurence" {
                if textField == fromTF {
                    fromTF.placeholder = "From City"
                    CallShowCityListAPI(str: textField.text ?? "")
                    
                }else {
                    toTF.placeholder = "To city"
                    CallShowCityListAPI(str: textField.text ?? "")
                }
            }else {
                if textField == fromTF {
                    fromTF.placeholder = "From City"
                    CALL_GET_AIRLINE_LIST_API(str: textField.text ?? "")
                    
                }else {
                    toTF.placeholder = "To city"
                    CALL_GET_AIRLINE_LIST_API(str: textField.text ?? "")
                }
            }
        }
        
        
        
    }
    
    
   
    
    
   
    
    
}


extension InsurenceSearchTVCell {
    
    
    //MARK: - INSURENCE
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
       
        if txtbool == true {
            fromCityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromCityTV.reloadData()
            }
        }else {
            toCityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                toCityTV.reloadData()
            }
        }
        
    }
    
    //MARK: - FASTRACK
    
    func CALL_GET_AIRLINE_LIST_API(str:String) {
        payload["term"] = str
        airlineViewModel?.CALL_GET_AIRLINE_LIST_API(dictParam: payload)
    }
    
    func airlineList(response: [FastrackAirlineListModel]) {
        airlineList = response
        
        
        if txtbool == true {
            fromCityTVHeight.constant = CGFloat(airlineList.count * 80)
            DispatchQueue.main.async {[self] in
                fromCityTV.reloadData()
            }
        }else {
            toCityTVHeight.constant = CGFloat(airlineList.count * 80)
            DispatchQueue.main.async {[self] in
                toCityTV.reloadData()
            }
        }
    }
    
    
}



extension InsurenceSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    func setupTV() {
        fromCityTV.delegate = self
        fromCityTV.dataSource = self
        fromCityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        toCityTV.delegate = self
        toCityTV.dataSource = self
        toCityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if journeyType == "Insurence" {
                if tableView == fromCityTV {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                        cell.selectionStyle = .none
                        cell.titlelbl.text = cityList[indexPath.row].label
                        cell.subTitlelbl.text = cityList[indexPath.row].name
                        cell.id = cityList[indexPath.row].id ?? ""
                        cell.cityname = cityList[indexPath.row].name ?? ""
                        cell.citycode = cityList[indexPath.row].code ?? ""
                        ccell = cell
                    }
                }else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                        cell.selectionStyle = .none
                        cell.titlelbl.text = cityList[indexPath.row].label
                        cell.subTitlelbl.text = cityList[indexPath.row].name
                        cell.id = cityList[indexPath.row].id ?? ""
                        cell.cityname = cityList[indexPath.row].name ?? ""
                        cell.citycode = cityList[indexPath.row].code ?? ""
                        ccell = cell
                    }
                }
            }else {
                if tableView == fromCityTV {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                        cell.selectionStyle = .none
                        cell.titlelbl.text = airlineList[indexPath.row].label
                        cell.subTitlelbl.text = airlineList[indexPath.row].name
                        cell.id = airlineList[indexPath.row].id ?? ""
                        cell.cityname = airlineList[indexPath.row].name ?? ""
                        cell.citycode = airlineList[indexPath.row].code ?? ""
                        cell.fasttrackid = airlineList[indexPath.row].fast_track_id ?? ""
                        ccell = cell
                    }
                }else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                        cell.selectionStyle = .none
                        cell.titlelbl.text = airlineList[indexPath.row].label
                        cell.subTitlelbl.text = airlineList[indexPath.row].name
                        cell.id = airlineList[indexPath.row].id ?? ""
                        cell.fasttrackid = airlineList[indexPath.row].fast_track_id ?? ""
                        cell.cityname = airlineList[indexPath.row].name ?? ""
                        cell.citycode = airlineList[indexPath.row].code ?? ""
                        ccell = cell
                    }
                }
            }
            
        }
        
        
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if tableView == fromCityTV {
                
                fromTF.text = cityList[indexPath.row].label ?? ""
                fromTF.resignFirstResponder()
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                    if journeyType == "Insurence" {
                        
                        
                        if let selectedJType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                            if selectedJType == "circle" {
                                
                                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.irfromCity)
                                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.irfromlocid)
                                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.irfromairport)
                                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.irfromcityname)
                            }else {
                                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.ifromCity)
                                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.ifromlocid)
                                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.ifromairport)
                                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.ifromcityname)
                                
                            }
                            
                        }
                        
                    }else {
                        defaults.set(airlineList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.frfromCity)
                        defaults.set(airlineList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.frfromlocid)
                        defaults.set("\(airlineList[indexPath.row].city ?? "") (\(airlineList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.frfromairport)
                        defaults.set(airlineList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.frfromcityname)
                        defaults.set(airlineList[indexPath.row].fast_track_id ?? "", forKey: UserDefaultsKeys.fromfstcode)

                    }
                    
                    
                    
                    fromCityTVHeight.constant = 0
                }
            }else {
                
                toTF.text = cityList[indexPath.row].label ?? ""
                toTF.resignFirstResponder()
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                    if journeyType == "Insurence" {
                        if let selectedJType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                            if selectedJType == "circle" {
                                
                                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.irtoCity)
                                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.irtolocid)
                                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.irtoairport)
                                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.irtocityname)
                            }else {
                                
                                
                                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.itoCity)
                                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.itolocid)
                                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.itoairport)
                                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.itocityname)
                                
                            }
                            
                        }
                    }else {
                        
                        
                        
                        defaults.set(airlineList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.frtoCity)
                        defaults.set(airlineList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.frtolocid)
                        defaults.set("\(airlineList[indexPath.row].city ?? "") (\(airlineList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.frtoairport)
                        defaults.set(airlineList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.frtocityname)
                        defaults.set(airlineList[indexPath.row].fast_track_id ?? "", forKey: UserDefaultsKeys.tofstcode)
                    }
                    
                }
                
                toCityTVHeight.constant = 0
            }
        }
        
        
        
    }
    
    
}

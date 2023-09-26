//
//  MultiCityCVCell.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit
import DropDown

protocol MultiCityCVCellDelegate {
    func didtapOnSwapCityBtn(cell:MultiCityCVCell)
    func didTapOnDeleteMultiCityTrip(cell:MultiCityCVCell)
    
    
    func didTapOnFromCityBtn(cell:MultiCityCVCell)
    func didTapOnToCityBtn(cell:MultiCityCVCell)
    func didTapOnDateBtn(cell:MultiCityCVCell)
}

class MultiCityCVCell: UICollectionViewCell, SelectCityViewModelProtocal,UITextFieldDelegate {
    func ShowCityListMulticity(response: [SelectCityModel]) {
        
    }
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromToView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var cancelImg: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var fromCityname: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var fromCityBtn: UIButton!
    @IBOutlet weak var toCityBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromcityTV: UITableView!
    @IBOutlet weak var fromcityTVHeight: NSLayoutConstraint!
    
    var cityViewModel: SelectCityViewModel?
    var payload = [String:Any]()
    var cityNameArray = [String]()
    var txtbool = Bool()
    var delegate:MultiCityCVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        cityViewModel = SelectCityViewModel(self)
    }
    
    override func prepareForReuse() {
        cancelBtnView.isHidden = true
    }
    
    
    
    
    func setupUI() {
        setupTV()
        fromcityTVHeight.constant = 0
        CallShowCityListAPI(str: "")
        
        
        
        cancelBtn.setTitle("", for: .normal)
        cancelBtn.addTarget(self, action: #selector(didTapOnDeleteMultiCityTrip(_:)), for: .touchUpInside)
        cancelImg.image = UIImage(named: "close")
        
        holderView.backgroundColor = .WhiteColor
        setupViews(v: fromToView, radius: 5, color: HexColor("#FCFCFC"))
        setupViews(v: toView, radius: 5, color: HexColor("#FCFCFC"))
        setupViews(v: dateView, radius: 5, color: HexColor("#FCFCFC"))
        
        
        cancelBtnView.backgroundColor = .clear
        
        setupLabels(lbl: fromCityname, text: "Dubai", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: toCityNamelbl, text: "Kuwait", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: datelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14))
        
        fromCityBtn.setTitle("", for: .normal)
        toCityBtn.setTitle("", for: .normal)
        dateBtn.setTitle("", for: .normal)
        fromCityBtn.addTarget(self, action: #selector(didTapOnFromCityBtn(_:)), for: .touchUpInside)
        toCityBtn.addTarget(self, action: #selector(didTapOnToCityBtn(_:)), for: .touchUpInside)
        dateBtn.addTarget(self, action: #selector(didTapOnDateBtn(_:)), for: .touchUpInside)
        
        
        cancelBtnView.isHidden = true
        
        
        fromTF.tag = 1
        fromTF.textColor = .AppLabelColor
        fromTF.font = .LatoSemibold(size: 18)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(16)
        fromTF.placeholder = "Origin"
        
        toTF.textAlignment = .center
        toTF.tag = 2
        toTF.textColor = .AppLabelColor
        toTF.font = .LatoSemibold(size: 18)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTF.setLeftPaddingPoints(16)
        toTF.placeholder = "Destination"
        
        fromTF.isHidden = true
        toTF.isHidden = true
        //        fromCityname.isHidden = true
        //        toCityNamelbl.isHidden = true
        
        
        setupTV()
    }
    
    
    func setupTV() {
        fromcityTV.delegate = self
        fromcityTV.dataSource = self
        fromcityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @objc func didtapOnSwapCityBtn(_ sender:UIButton) {
        delegate?.didtapOnSwapCityBtn(cell: self)
    }
    
    @objc func didTapOnDeleteMultiCityTrip(_ sender:UIButton) {
        delegate?.didTapOnDeleteMultiCityTrip(cell: self)
    }
    
    
    @objc func didTapOnFromCityBtn(_ sender:UIButton){
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    @objc func didTapOnToCityBtn(_ sender:UIButton){
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    @objc func didTapOnDateBtn(_ sender:UIButton){
        delegate?.didTapOnDateBtn(cell: self)
    }
    
    
    
    //MARK: - Text Filed Editing Changed
    
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        if textField == fromTF {
            txtbool = true
            if textField.text?.isEmpty == true {
                
            }else {
                self.fromCityname.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                
            }
        }else {
            txtbool = false
            if textField.text?.isEmpty == true {
            }else {
                self.toCityNamelbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
            }
        }
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTF {
            fromTF.placeholder = "Origin"
            CallShowCityListAPI(str: textField.text ?? "")
        }else {
            toTF.placeholder = "Destination"
            CallShowCityListAPI(str: textField.text ?? "")
        }
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        print(cityList)
        if txtbool == true {
            fromcityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromcityTV.reloadData()
            }
        }else {
            fromcityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromcityTV.reloadData()
            }
        }
        
    }
    
    
    
    
}



extension MultiCityCVCell:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == fromcityTV {
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
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            print(cell.id)
            print(cell.citycode)
            print(cell.cityname)
            
            if txtbool == true {
                
                fromTF.text = cityList[indexPath.row].code ?? ""
                fromTF.resignFirstResponder()
                toTF.placeholder = "Destination"
                toTF.becomeFirstResponder()
                
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.mfromCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.mfromlocid)
                
                
                
                fromcityTVHeight.constant = 0
            }else {
                
                toTF.text = cityList[indexPath.row].code ?? ""
                toTF.resignFirstResponder()
                
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.mtoCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.mtolocid)
                
                fromcityTVHeight.constant = 0
            }
        }
    }
    
    
    
    
}

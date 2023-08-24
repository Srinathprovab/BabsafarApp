//
//  ExploreTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit


protocol ExploreTVCellDelegate {
    func didTapOnSearchBtnAction(cell:ExploreTVCell)
}

class ExploreTVCell: TableViewCell, FastrackAirlineListViewModelDelegate {
    
    
    
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var airlineList:[FastrackAirlineListModel] = []
    var payload = [String:Any]()
    var cityViewModel: FastrackAirlineListViewModel?
    var delegate:ExploreTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        cityViewModel = FastrackAirlineListViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        setupTV()
        tvHeight.constant = 0
        CallShowCityListAPI(str: "kuwait")
    }
    
    func updateHeight() {
        
    }
    
    
    func setupUI() {
        setupTextField(tf: searchTF)
    }
    
    
    func setupTextField(tf:UITextField) {
        tf.tag = 1
        tf.textColor = .AppLabelColor
        tf.font = .LatoSemibold(size: 16)
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        tf.setLeftPaddingPoints(15)
    }
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        if textField.text?.isEmpty == true {
            
        }else {
            CallShowCityListAPI(str: textField.text ?? "")
        }
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        // CallShowCityListAPI(str: textField.text ?? "")
    }
    
    
    
    
    @IBAction func didTapOnSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchBtnAction(cell: self)
    }
    
    
}



extension ExploreTVCell {
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CALL_GET_AIRLINE_LIST_API(dictParam: payload)
    }
    
    func airlineList(response: [FastrackAirlineListModel]) {
        airlineList = response
        
        
        DispatchQueue.main.async {[self] in
            tvHeight.constant = CGFloat(airlineList.count * 80)
            searchTV.reloadData()
        }
    }
    
    
}


extension ExploreTVCell:UITableViewDelegate, UITableViewDataSource {
    
    func setupTV() {
        searchTV.delegate = self
        searchTV.dataSource = self
        searchTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airlineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
            cell.selectionStyle = .none
            
            cell.titlelbl.text = airlineList[indexPath.row].label
            cell.subTitlelbl.text = airlineList[indexPath.row].name
            cell.id = airlineList[indexPath.row].id ?? ""
            cell.cityname = airlineList[indexPath.row].name ?? ""
            cell.citycode = airlineList[indexPath.row].code ?? ""
            
            ccell = cell
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaults.set(airlineList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.qrfromCity)
        defaults.set(airlineList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.qlocid)
        defaults.set(airlineList[indexPath.row].fast_track_id ?? "", forKey: UserDefaultsKeys.qfstcode)
        searchTF.text = airlineList[indexPath.row].label ?? ""
        tvHeight.constant = 0
    }
    
    
}

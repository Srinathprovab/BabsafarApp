//
//  MultiCityTripFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 11/08/22.
//

import UIKit
protocol MultiCityTripFlightResultTVCellDelegate {
    
    func didTapOnFlightDetailsBtnAction(cell:MultiCityTripFlightResultTVCell)
    func didTapOnBookNowBtnAction(cell:MultiCityTripFlightResultTVCell)
    func didTapOnSimilarOptionBtnAction(cell:MultiCityTripFlightResultTVCell)

    
    
}

class MultiCityTripFlightResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var multiCityTripTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var refundableTypelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var similarimg: UIImageView!
    @IBOutlet weak var similarlbl: UILabel!
    @IBOutlet weak var similarbtn: UIButton!
    @IBOutlet weak var markupkwdlbl: UILabel!
    
    
    var delegate:MultiCityTripFlightResultTVCellDelegate?
    var arrayCount = Int()
    var totalPrice = String()
    var selectedResult = String()
    var taxes = String()
    var APICurrencyType = String()
    var kwdPrice = String()
    var mflight_details : MCFlight_details?
    var displayPrice = String()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
        
        selectedResult = cellInfo?.TotalQuestions ?? ""
        taxes = cellInfo?.questionBase ?? ""
        self.mflight_details = cellInfo?.moreData as? MCFlight_details
        arrayCount = self.mflight_details?.summary?.count ?? 0
        tvHeight.constant = CGFloat((arrayCount * 110))
        displayPrice = cellInfo?.headerText ?? ""
        pricelbl.text = "\(cellInfo?.price ?? ""):\(cellInfo?.title ?? "")"
        setAttributedString1(str1: cellInfo?.price ?? "", str2: cellInfo?.errormsg ?? "")
        if cellInfo?.key1 == "Refundable" {
            setuplabels(lbl: refundableTypelbl, text: "Refundable", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 14), align: .center)
        }else {
            setuplabels(lbl: refundableTypelbl, text: "Non Refundable", textcolor: .AppBtnColor, font: .LatoRegular(size: 14), align: .center)
        }
        
        
        if cellInfo?.shareLink == "similar" {
            hideSimilarlbls()
        }
        
        if let list = cellInfo?.data as? [[MCJ_flight_list]] , (list.count - 1) != 0 {
            markupkwdlbl.text = "More Similar Options (\(list.count - 1))"
            showSimilarlbls()
        }
//        else {
//            hideSimilarlbls()
//        }
        
        
        multiCityTripTV.reloadData()
    }
    
    
    func hideSimilarlbls(){
        similarimg.isHidden = true
        similarlbl.isHidden = true
        similarbtn.isHidden = true
    }
    
    func showSimilarlbls(){
        similarimg.isHidden = false
        similarlbl.isHidden = false
        similarbtn.isHidden = false
    }
    
    func setupUI() {
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        setuplabels(lbl: pricelbl, text: "150.00", textcolor: HexColor("#64276F"), font: .LatoBold(size: 16), align: .right)
        setuplabels(lbl: markupkwdlbl, text: "150.00", textcolor: HexColor("#64276F"), font: .LatoBold(size: 14), align: .right)
        hideSimilarlbls()
        setupTV()
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupTV() {
        multiCityTripTV.register(UINib(nibName: "MCTripFlightTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        multiCityTripTV.delegate = self
        multiCityTripTV.dataSource = self
        multiCityTripTV.tableFooterView = UIView()
        multiCityTripTV.showsVerticalScrollIndicator = false
        multiCityTripTV.showsHorizontalScrollIndicator = false
        multiCityTripTV.isScrollEnabled = false
        
        multiCityTripTV.separatorStyle = .none
    }
    
    
    
    
    func setAttributedString1(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 14),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 16),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        markupkwdlbl.attributedText = combination
        
    }
    
    
    @IBAction func didTapOnFlightDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightDetailsBtnAction(cell: self)
    }
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnSimilarOptionBtnAction(_ sender: Any) {
        delegate?.didTapOnSimilarOptionBtnAction(cell: self)
    }
    
    
}


extension MultiCityTripFlightResultTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MCTripFlightTVCell {
            cell.selectionStyle = .none
            
            let data = mflight_details?.summary?[indexPath.row]
            
            cell.airlineNamelbl.text = "\( data?.operator_name ?? "") (\(data?.flight_number ?? "")-\(data?.operator_code ?? ""))"
            cell.airlinelogo.sd_setImage(with: URL(string: data?.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            cell.fromCityShortlbl.text = data?.origin?.loc
            cell.fromCityTimelbl.text = data?.origin?.time
            cell.toCityShortlbl.text = data?.destination?.loc
            cell.toCityTimelbl.text = data?.destination?.time
            cell.hourslbl.text = data?.duration
            
            
            
            ccell = cell
        }
        return ccell
    }
    
}

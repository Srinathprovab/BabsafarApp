//
//  SearchFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import SDWebImage
import UIView_Shimmer

protocol SearchFlightResultTVCellDelegate {
    func didTapOnViewVoucherBtn(cell:SearchFlightResultTVCell)
    func didTapOnBookNowBtn(cell:SearchFlightResultTVCell)
    func didTapOnFlightDetailsBtnAction(cell:SearchFlightResultTVCell)
    func didTapOnSimilarFlightsButtonAction(cell:SearchFlightResultTVCell)
    
}

class SearchFlightResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airwaysLogoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityShortlbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noStopslbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityShortlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var imagesHolderView: UIView!
    @IBOutlet weak var bagImg: UIImageView!
    @IBOutlet weak var bagWeightlbl: UILabel!
    @IBOutlet weak var suitCaseImg: UIImageView!
    @IBOutlet weak var suitcaseWeightlbl: UILabel!
    @IBOutlet weak var imagesHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var viewVoucherBtn: UIButton!
    @IBOutlet weak var imagesHolder2: UIStackView!
    @IBOutlet weak var holderViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var airoplaneImg: UIImageView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var flightsDetailsBtnView: UIView!
    @IBOutlet weak var flightsDetailslbl: UILabel!
    @IBOutlet weak var flightsDetailsBtn: UIButton!
    @IBOutlet weak var moreSimlarOptionlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var markuppricelbl: UILabel!
    
    @IBOutlet weak var similarFlightsTV: UITableView!
    @IBOutlet weak var similarFlightsTVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var similarBtn: UIButton!
    @IBOutlet weak var similarimg: UIImageView!
    var displayPrice = String()
    var delegate:SearchFlightResultTVCellDelegate?
    var selectedResult = String()
    var similarList = [[J_flight_list]]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        hideSimilarlbl()
    }
    
    
    func convertToDesiredFormat(_ inputString: String) -> String {
        if let number = Int(inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            if inputString.contains("Kilograms") {
                return "\(number) kg"
            } else if inputString.contains("NumberOfPieces") {
                return "\(number) pc"
            }
        }
        return "Invalid input format."
    }
    
    
    override func updateUI() {
        
        bagWeightlbl.text = convertToDesiredFormat(cellInfo?.Weight_Allowance ?? "")
        
        titlelbl.text = cellInfo?.title
        self.airwaysLogoImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        fromCityTimelbl.text = cellInfo?.text
        fromCityShortlbl.text = cellInfo?.tempText
        toCityTimelbl.text = cellInfo?.headerText
        toCityShortlbl.text = cellInfo?.buttonTitle
        hourslbl.text = cellInfo?.questionType
        
        //        similarList = cellInfo?.moreData as! [[J_flight_list]]
        
        if cellInfo?.questionBase == "0" {
            noStopslbl.text = "Non - Stop"
        }else {
            noStopslbl.text = "\(cellInfo?.questionBase ?? "") Stops"
        }
        
        
        selectedResult = cellInfo?.TotalQuestions ?? ""
        displayPrice = cellInfo?.subTitle ?? ""
        
        //  kwdPricelbl.text = "\(cellInfo?.price ?? ""):\(cellInfo?.subTitle ?? "")"
        setAttributedString(str1: cellInfo?.price ?? "", str2: cellInfo?.subTitle ?? "")
        
        
        if let similarList1 = cellInfo?.moreData as? [[J_flight_list]], (similarList1.count - 1) != 0 {
            setuplabels(lbl: moreSimlarOptionlbl, text: "More similar options(\(similarList1.count))", textcolor: .WhiteColor, font: .LatoRegular(size: 10), align: .right)
            showSimilarlbl()
        }
        switch cellInfo?.key {
            
            
        case "oneway":
            deplbl.isHidden = true
            airoplaneImg.isHidden = true
            leftConstraint.constant = 8
            rightConstraint.constant = 8
            break
        case "booked":
            shadowView(yourView: holderView)
            imagesHolderHeight.constant = 0
            imagesHolderView.isHidden = true
            fromCityShortlbl.textColor = HexColor("#808089")
            toCityShortlbl.textColor = HexColor("#808089")
            toCityShortlbl.textColor = HexColor("#808089")
            hourslbl.textColor = HexColor("#808089")
            noStopslbl.textColor = HexColor("#808089")
            
            break
            
        case "mybooking":
            viewVoucherBtn.isHidden = false
            imagesHolder2.isHidden = true
            
            viewVoucherBtn.isHidden = false
            viewVoucherBtn.setTitle("View Voucher", for: .normal)
            viewVoucherBtn.setTitleColor(.WhiteColor, for: .normal)
            viewVoucherBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
            
            
        case "bookingdetails":
            deplbl.isHidden = true
            airoplaneImg.isHidden = true
            leftConstraint.constant = 8
            rightConstraint.constant = 8
            viewVoucherBtn.isHidden = false
            imagesHolder2.isHidden = true
            break
            
        default:
            break
        }
        
        
        
        if cellInfo?.key1 == "Refundable" {
            
            setuplabels(lbl: refundablelbl, text: cellInfo?.key1 ?? "", textcolor: .WhiteColor, font: .LatoRegular(size: 13), align: .center)
        }else {
            
            setuplabels(lbl: refundablelbl, text: cellInfo?.key1 ?? "", textcolor: .WhiteColor, font: .LatoRegular(size: 13), align: .center)
        }
        
        
        setAttributedString1(str1: cellInfo?.price ?? "KWD", str2: cellInfo?.errormsg ?? "")
        //  markuppricelbl.text = "\(cellInfo?.price ?? "KWD"):\(cellInfo?.errormsg ?? "")"
        //        if cellInfo?.errormsg != "0" {
        //
        //            setAttributedString1(str1: cellInfo?.price ?? "KWD", str2: cellInfo?.errormsg ?? "")
        //        }else {
        //            markuppricelbl.textColor = .WhiteColor
        //        }
        
        
        if cellInfo?.shareLink == "similar" {
            self.moreSimlarOptionlbl.isHidden = true
            self.similarimg.isHidden = true
        }
        
        
    }
    
    
    
    
    
    
    func setAttributedString(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 18)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        kwdPricelbl.attributedText = combination
        
    }
    
    
    func setAttributedString1(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 10),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 14),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        markuppricelbl.attributedText = combination
        
    }
    
    
    func setupsimilarList(){
        similarFlightsTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        similarFlightsTV.delegate = self
        similarFlightsTV.dataSource = self
        similarFlightsTV.tableFooterView = UIView()
        similarFlightsTV.showsVerticalScrollIndicator = false
        similarFlightsTV.separatorStyle = .none
        similarFlightsTV.isScrollEnabled = false
        
        similarFlightsTVHeight.constant = (CGFloat(similarList.count) * 30)
        similarFlightsTV.isHidden = false
        similarFlightsTV.reloadData()
    }
    
    
    func setupUI() {
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 10)
        
        
        airwaysLogoImg.image = UIImage(named: "airways")
        setuplabels(lbl: titlelbl, text: "Qatar Airways (QR10003)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: fromCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .left)
        setuplabels(lbl: fromCityShortlbl, text: "dubai (dXB)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "07:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .right)
        setuplabels(lbl: toCityShortlbl, text: "kuwait (KWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: hourslbl, text: "1h 40mis", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: noStopslbl, text: "No Stops", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: kwdPricelbl, text: "150.00", textcolor: HexColor("#64276F"), font: .LatoBold(size: 22), align: .right)
        setuplabels(lbl: markuppricelbl, text: "150.00", textcolor: HexColor("#64276F"), font: .LatoBold(size: 22), align: .right)
        //  markuppricelbl.isHidden = true
        
        
        
        setuplabels(lbl: deplbl, text: "", textcolor: HexColor("#808089"), font: .LatoLight(size: 12), align: .right)
        
        
        imagesHolderHeight.constant = 25
        imagesHolderView.isHidden = false
        imagesHolderView.backgroundColor = .AppCalenderDateSelectColor
        bagImg.image = UIImage(named: "bag")
        suitCaseImg.image = UIImage(named: "suit")
        
        
        setuplabels(lbl: suitcaseWeightlbl, text: "7 kg", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: bagWeightlbl, text: "25 kg", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
        hourslbl.addBottomBorderWithColor(color: .AppCalenderDateSelectColor, width: 1)
        
        viewVoucherBtn.isHidden = true
        viewVoucherBtn.setTitle("Book Now", for: .normal)
        viewVoucherBtn.setTitleColor(.WhiteColor, for: .normal)
        viewVoucherBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
        viewVoucherBtn.backgroundColor = HexColor("#F05324")
        
        deplbl.text = ""
        airoplaneImg.image = UIImage(named: "airo1")
        toCityShortlbl.numberOfLines = 1
        fromCityShortlbl.numberOfLines = 1
        
        imagesHolderView.layer.cornerRadius = 10
        imagesHolderView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        imagesHolderView.clipsToBounds = true
        
        
        flightsDetailsBtnView.backgroundColor = HexColor("#FFCC33")
        flightsDetailsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: flightsDetailslbl, text: "Flight Details", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        flightsDetailsBtn.setTitle("", for: .normal)
        
        bookNowView.backgroundColor = .red
        bookNowView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: bookNowlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoSemibold(size: 12), align: .center)
        bookNowBtn.setTitle("", for: .normal)
        
        setupsimilarList()
        hideSimilarlbl()
    }
    
    
    func hideSimilarlbl(){
        similarimg.isHidden = true
        similarBtn.isHidden = true
        moreSimlarOptionlbl.isHidden = true
    }
    
    func showSimilarlbl(){
        similarimg.isHidden = false
        similarBtn.isHidden = false
        moreSimlarOptionlbl.isHidden = false
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func shadowView(yourView:UIView){
        yourView.layer.borderWidth = 1
        yourView.layer.borderColor = UIColor.AppBorderColor.cgColor
        yourView.layer.shadowColor = UIColor.gray.cgColor
        yourView.layer.shadowOpacity = 0.3
        yourView.layer.shadowOffset = CGSize.zero
        yourView.layer.shadowRadius = 6
    }
    
    
    func hidePerpersonLbl() {
        deplbl.text = ""
        airoplaneImg.image = UIImage(named: "airo2")
        kwdPricelbl.isHidden = true
        imagesHolderView.backgroundColor = HexColor("#EBEBEB")
        bagImg.image = UIImage(named: "bag")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#808089"))
        suitCaseImg.image = UIImage(named: "suit")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#808089"))
        bagWeightlbl.textColor = HexColor("#808089")
        suitcaseWeightlbl.textColor = HexColor("#808089")
        flightsDetailsBtnView.isHidden = true
        viewVoucherBtn.isHidden = true
        bookNowView.isHidden = true
    }
    
    
    func hide() {
        imagesHolderView.isHidden = true
        self.airoplaneImg.isHidden = true
        self.kwdPricelbl.isHidden = true
        // self.deplbl.isHidden = true
        leftConstraint.constant = 8
        rightConstraint.constant = 8
    }
    
    @IBAction func didTapOnViewVoucherBtn(_ sender: Any) {
        
        
        if cellInfo?.key == "mybooking" {
            delegate?.didTapOnViewVoucherBtn(cell: self)
        }
    }
    
    
    
    //    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
    //        delegate?.didTapOnBookNowBtn(cell: self)
    //    }
    
    
    @IBAction func didTapOnFlightDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightDetailsBtnAction(cell: self)
    }
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        delegate?.didTapOnBookNowBtn(cell: self)
    }
    
    @IBAction func didTapOnSimilarFlightsButtonAction(_ sender: Any) {
        delegate?.didTapOnSimilarFlightsButtonAction(cell: self)
    }
    
}



extension SearchFlightResultTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
            cell.holderView.backgroundColor = .red
            cell.titlelbl.text = "SRinathhhhhh"
            c = cell
        }
        return c
    }
    
    
    
}

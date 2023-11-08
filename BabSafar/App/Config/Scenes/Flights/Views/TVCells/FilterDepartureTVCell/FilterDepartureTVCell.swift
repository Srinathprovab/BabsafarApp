//
//  FilterDepartureTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit

protocol FilterDepartureTVCellDelegate {
    func didTapOnDropDownBtn(cell:FilterDepartureTVCell)
    
    func didTapOnTimeBtn(cell:FilterDepartureTVCell)
    
}

class FilterDepartureTVCell: TableViewCell {
    
    
    @IBOutlet weak var ButtonsHolderView: UIStackView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    
    @IBOutlet weak var timeView1: UIView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var time1lbl: UILabel!
    @IBOutlet weak var time1Bn: UIButton!
    
    @IBOutlet weak var timeView2: UIView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var time2lbl: UILabel!
    @IBOutlet weak var time2Bn: UIButton!
    
    @IBOutlet weak var timeView3: UIView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var time3lbl: UILabel!
    @IBOutlet weak var time3Bn: UIButton!
    
    @IBOutlet weak var timeView4: UIView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var time4lbl: UILabel!
    @IBOutlet weak var time4Bn: UIButton!
    
    
    var timeString = String()
    var b = true
    var showbool = true
    var delegate:FilterDepartureTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected == true {
            expand()
        }else {
            hide()
        }
    }
    
    override func prepareForReuse() {
        hide()
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        
    //    if titlelbl.text == "Departure Time"{
            
//            switch filterModel.departureTime {
//            case "12AM - 6AM":
//                tapOnTimeOneBtn()
//                break
//
//
//            case "6AM - 12PM":
//                tapOnTime2Btn()
//                break
//
//
//            case "12PM - 6PM":
//                tapOnTime3Btn()
//                break
//
//
//            case "6PM - 12AM":
//                tapOnTime4Btn()
//                break
//
//
//            case "":
//                reset()
//                break
//
//
//            default:
//
//                break
//            }
            
            
//        }else {
//
//            switch filterModel.arrivalTime {
//            case "12AM - 6AM":
//                tapOnTimeOneBtn()
//                break
//
//
//            case "6AM - 12PM":
//                tapOnTime2Btn()
//                break
//
//
//            case "12PM - 6PM":
//                tapOnTime3Btn()
//                break
//
//
//            case "6PM - 12AM":
//                tapOnTime4Btn()
//                break
//
//            case "":
//                reset()
//                break
//
//
//
//            default:
//
//                break
//            }
//        }
        
        
        
    }
    
    
    func setupUI() {
        
        viewHeight.constant = 60
        dropdownBtn.isHidden = true
        
        ButtonsHolderView.layer.cornerRadius = 4
        ButtonsHolderView.clipsToBounds = true
        ButtonsHolderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        ButtonsHolderView.layer.borderWidth = 1
        
        setupViews(v: timeView1, radius: 0, color: .WhiteColor)
        setupViews(v: timeView2, radius: 0, color: .WhiteColor)
        setupViews(v: timeView3, radius: 0, color: .WhiteColor)
        setupViews(v: timeView4, radius: 0, color: .WhiteColor)
        
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoMedium(size: 17))
        setupLabels(lbl: time1lbl, text: "12AM - 6AM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time2lbl, text: "6AM - 12PM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time3lbl, text: "12PM - 6PM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time4lbl, text: "6PM - 12AM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        downImg.image = UIImage(named: "down")
        img1.image = UIImage(named: "mor1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        img2.image = UIImage(named: "mor2")
        img3.image = UIImage(named: "mor3")
        img4.image = UIImage(named: "mor4")
        
        dropdownBtn.setTitle("", for: .normal)
        time1Bn.setTitle("", for: .normal)
        time2Bn.setTitle("", for: .normal)
        time3Bn.setTitle("", for: .normal)
        time4Bn.setTitle("", for: .normal)
        
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
    
    
    
    @IBAction func didTapOnDropDownBtn(_ sender: Any) {
        delegate?.didTapOnDropDownBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTimeOneBtn(_ sender: Any) {
        tapOnTimeOneBtn()
    }
    
    
    func tapOnTimeOneBtn(){
        timeView1.backgroundColor = .AppCalenderDateSelectColor
        img1.image = UIImage(named: "mor1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        time1lbl.textColor = .WhiteColor
        
        timeView2.backgroundColor = .WhiteColor
        img2.image = UIImage(named: "mor2")
        time2lbl.textColor = .AppLabelColor
        
        timeView3.backgroundColor = .WhiteColor
        img3.image = UIImage(named: "mor3")
        time3lbl.textColor = .AppLabelColor
        
        timeView4.backgroundColor = .WhiteColor
        img4.image = UIImage(named: "mor4")
        time4lbl.textColor = .AppLabelColor
        
        timeString = time1lbl.text ?? ""
        delegate?.didTapOnTimeBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTime2Btn(_ sender: Any) {
        tapOnTime2Btn()
    }
    
    func tapOnTime2Btn(){
        timeView1.backgroundColor = .WhiteColor
        img1.image = UIImage(named: "mor1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        time1lbl.textColor = .AppLabelColor
        
        timeView2.backgroundColor = .AppCalenderDateSelectColor
        img2.image = UIImage(named: "mor2")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        time2lbl.textColor = .WhiteColor
        
        timeView3.backgroundColor = .WhiteColor
        img3.image = UIImage(named: "mor3")
        time3lbl.textColor = .AppLabelColor
        
        timeView4.backgroundColor = .WhiteColor
        img4.image = UIImage(named: "mor4")
        time4lbl.textColor = .AppLabelColor
        
        timeString = time2lbl.text ?? ""
        delegate?.didTapOnTimeBtn(cell: self)
        
    }
    
    
    @IBAction func didTapOnTime3Btn(_ sender: Any) {
        tapOnTime3Btn()
    }
    
    
    func tapOnTime3Btn(){
        timeView1.backgroundColor = .WhiteColor
        img1.image = UIImage(named: "mor1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        time1lbl.textColor = .AppLabelColor
        
        timeView2.backgroundColor = .WhiteColor
        img2.image = UIImage(named: "mor2")
        time2lbl.textColor = .AppLabelColor
        
        timeView3.backgroundColor = .AppCalenderDateSelectColor
        img3.image = UIImage(named: "mor3")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        time3lbl.textColor = .WhiteColor
        
        timeView4.backgroundColor = .WhiteColor
        img4.image = UIImage(named: "mor4")
        time4lbl.textColor = .AppLabelColor
        
        timeString = time3lbl.text ?? ""
        delegate?.didTapOnTimeBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTime4Btn(_ sender: Any) {
        tapOnTime4Btn()
    }
    
    
    func tapOnTime4Btn(){
        timeView1.backgroundColor = .WhiteColor
        img1.image = UIImage(named: "mor1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        time1lbl.textColor = .AppLabelColor
        
        timeView2.backgroundColor = .WhiteColor
        img2.image = UIImage(named: "mor2")
        time2lbl.textColor = .AppLabelColor
        
        timeView3.backgroundColor = .WhiteColor
        img3.image = UIImage(named: "mor3")
        time3lbl.textColor = .AppLabelColor
        
        timeView4.backgroundColor = .AppCalenderDateSelectColor
        img4.image = UIImage(named: "mor4")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        time4lbl.textColor = .WhiteColor
        
        timeString = time4lbl.text ?? ""
        delegate?.didTapOnTimeBtn(cell: self)
        
    }
    
    
    
    func reset(){
        
        setupViews(v: timeView1, radius: 0, color: .WhiteColor)
        setupViews(v: timeView2, radius: 0, color: .WhiteColor)
        setupViews(v: timeView3, radius: 0, color: .WhiteColor)
        setupViews(v: timeView4, radius: 0, color: .WhiteColor)
        
        setupLabels(lbl: time1lbl, text: "12AM - 6AM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time2lbl, text: "6AM - 12PM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time3lbl, text: "12PM - 6PM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: time4lbl, text: "6PM - 12AM", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
    }
    
    
    func expand() {
        viewHeight.constant = 60
    }
    
    func hide() {
        viewHeight.constant = 0
    }
    
}

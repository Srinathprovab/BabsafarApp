//
//  CommonFromCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit


protocol CommonFromCityTVCellDelegate {
    func viewBtnAction(cell:CommonFromCityTVCell)
    func didTapOnDual1Btn(cell:CommonFromCityTVCell)
    func didTapOnDual2Btn(cell:CommonFromCityTVCell)
}
class CommonFromCityTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dualView: UIStackView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var dropImg: UIImageView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var dual1lbl1: UILabel!
    @IBOutlet weak var dual1lbl2: UILabel!
    @IBOutlet weak var dual1Btn: UIButton!
    @IBOutlet weak var dual2lbl1: UILabel!
    @IBOutlet weak var dual2lbl2: UILabel!
    @IBOutlet weak var dual2Btn: UIButton!
    
    
    var delegate:CommonFromCityTVCellDelegate?
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
        
        titlelbl.text = cellInfo?.title
        subtitlelbl.text = cellInfo?.subTitle
        dropImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        
        
        
        switch cellInfo?.key {
        case "dual":
            dual1lbl1.text = cellInfo?.title
            dual1lbl2.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "+ Add checkin"
            dual2lbl1.text = cellInfo?.text
            dual2lbl2.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "+ Add checkout"
            holderView.isHidden = true
            dualView.isHidden = false
            break
        default:
            break
        }
    }
    
    func setupUI() {
        holderView.isHidden = false
        dualView.isHidden = true
        dualView.backgroundColor = .WhiteColor
        setupViews(v: holderView, radius: 4, color: HexColor("#FCFCFC"))
        setupViews(v: view1, radius: 4, color: HexColor("#FCFCFC"))
        setupViews(v: view2, radius: 4, color: HexColor("#FCFCFC"))
        
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        setupLabels(lbl: dual1lbl1, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: dual2lbl1, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        
        setupLabels(lbl: dual1lbl2, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: dual2lbl2, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        btn.setTitle("", for: .normal)
        dual1Btn.setTitle("", for: .normal)
        dual2Btn.setTitle("", for: .normal)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @IBAction func viewBtnAction(_ sender: Any) {
        delegate?.viewBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnDual1Btn(_ sender: Any) {
        delegate?.didTapOnDual1Btn(cell: self)
    }
    
    @IBAction func didTapOnDual2Btn(_ sender: Any) {
        delegate?.didTapOnDual2Btn(cell: self)
    }
}

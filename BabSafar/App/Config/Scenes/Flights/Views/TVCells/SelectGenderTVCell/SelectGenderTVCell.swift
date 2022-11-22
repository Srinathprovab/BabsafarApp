//
//  SelectGenderTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol SelectGenderTVCellDelegate {
    func didSelectMaleRadioBtn(cell:SelectGenderTVCell)
    func didSelectOnFemaleBtn(cell:SelectGenderTVCell)
    func didTapOnSaveBtn(cell:SelectGenderTVCell)
    
    
}

class SelectGenderTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var maleRadioImg: UIImageView!
    @IBOutlet weak var malelbl: UILabel!
    @IBOutlet weak var femaleRadioImg: UIImageView!
    @IBOutlet weak var femalelbl: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var genderView: UIStackView!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var savelbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    var gender = String()
    var delegate:SelectGenderTVCellDelegate?
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
        if cellInfo?.key == "gender" {
            saveBtnView.isHidden = true
            genderView.isHidden = false
            if cellInfo?.title == "male" {
                maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
                femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
            }else {
                maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
                femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
            }
            
        }else {
            saveBtnView.isHidden = false
            genderView.isHidden = true
        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        
        setupLabels(lbl: malelbl, text: "Male", textcolor: .AppLabelColor, font: .ManropeMedium(size: 16))
        setupLabels(lbl: femalelbl, text: "Female", textcolor: .AppLabelColor, font: .ManropeMedium(size: 16))
        setupLabels(lbl: savelbl, text: "Save", textcolor: .WhiteColor, font: .LatoMedium(size: 16))
        
        setupViews(v: saveBtnView, radius: 4, color: .AppTabSelectColor)
        
        maleBtn.setTitle("", for: .normal)
        femaleBtn.setTitle("", for: .normal)
        saveBtn.setTitle("", for: .normal)
        
        saveBtnView.isHidden = true
        genderView.isHidden = false
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @IBAction func didSelectMaleRadioBtn(_ sender: Any) {
        gender = "Male"
        delegate?.didSelectMaleRadioBtn(cell: self)
        maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func didSelectOnFemaleBtn(_ sender: Any) {
        gender = "Female"
        delegate?.didSelectOnFemaleBtn(cell: self)
        maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    @IBAction func didTapOnSaveBtn(_ sender: Any) {
        delegate?.didTapOnSaveBtn(cell: self)
    }
    
}

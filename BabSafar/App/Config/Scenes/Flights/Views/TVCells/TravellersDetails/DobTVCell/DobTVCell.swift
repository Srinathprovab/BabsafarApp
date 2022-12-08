//
//  DobTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/12/22.
//

import UIKit
protocol DobTVCellDelegate {
    func editingTextField(tf:UITextField)
    func donedatePicker(cell:DobTVCell)
    func cancelDatePicker(cell:DobTVCell)
}
class DobTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tfHolderView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var dropImage: UIImageView!
  
    var delegate:DobTVCellDelegate?
    let datePicker = UIDatePicker()
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
        dropImage.image = UIImage(named: cellInfo?.image ?? "")
        txtField.tag = cellInfo?.characterLimit ?? 0
        txtField.placeholder = cellInfo?.buttonTitle
        
        datePicker.maximumDate = Date()
        showDatePicker()
        
        
        if cellInfo?.key1 == "edit" {
            txtField.text = cellInfo?.text
        }
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        txtField.inputAccessoryView = toolbar
        txtField.inputView = datePicker
        
        
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 14), align: .left)
        tfHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: UIColor.lightGray.withAlphaComponent(0.5), cornerRadius: 4)
        tfHolderView.backgroundColor = .WhiteColor
       
        txtField.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
        txtField.delegate = self
        txtField.backgroundColor = .WhiteColor
        txtField.setLeftPaddingPoints(15)
        txtField.placeholder = cellInfo?.text
        txtField.font = .poppinsMedium(size: 15)
        txtField.isSecureTextEntry = false
       
    }
    
    
    
    @objc func editingTextField(_ tf: UITextField){
        print(tf.text)
        delegate?.editingTextField(tf: tf)
    }
    
}

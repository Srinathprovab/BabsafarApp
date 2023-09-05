//
//  ExploreLeadPassengerTVCell.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import UIKit
import DropDown

protocol  ExploreLeadPassengerTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnAdultBtnAction(cell:ExploreLeadPassengerTVCell)
    func didTapOnChildBtnAction(cell:ExploreLeadPassengerTVCell)
    func donedatePicker(cell:ExploreLeadPassengerTVCell)
    func cancelDatePicker(cell:ExploreLeadPassengerTVCell)
    func doneTimePicker(cell:ExploreLeadPassengerTVCell)
    func cancelTimePicker(cell:ExploreLeadPassengerTVCell)
    func didTapOnTerminalBtnAction(cell:ExploreLeadPassengerTVCell)
    
    
}

class ExploreLeadPassengerTVCell: TableViewCell {
    
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var terminalTF: UITextField!
    @IBOutlet weak var flightnoTF: UITextField!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depTimeTF: UITextField!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var adultView: BorderedView!
    @IBOutlet weak var childView: BorderedView!
    @IBOutlet weak var terminalView: BorderedView!
    
    let depTimePicker = UIDatePicker()
    let depDatePicker = UIDatePicker()
    var adultDropdown = DropDown()
    var childDropdown = DropDown()
    var terminalDropdown = DropDown()
    var delegate:ExploreLeadPassengerTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        setuptf(tf: fullnameTF, tag1: 111, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: terminalTF, tag1: 222, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: flightnoTF, tag1: 333, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: depDateTF, tag1: 4, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: depTimeTF, tag1: 5, leftpadding: 10, font: .LatoRegular(size: 12))
        
        setupAdultDropDown()
        setupChildDropDown()
        setupTerminalDropDown()
        showdebDatePicker()
        showdepTimePicker()
        
        
    }
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont){
        tf.backgroundColor = .clear
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    @IBAction func didTapOnAdultBtnAction(_ sender: Any) {
        adultDropdown.show()
    }
    
    
    
    
    @IBAction func didTapOnChildBtnAction(_ sender: Any) {
        childDropdown.show()
    }
    
    
    
    @IBAction func didTapOnTerminalBtnAction(_ sender: Any) {
        terminalDropdown.show()
    }
    
    
}



extension ExploreLeadPassengerTVCell {
    
    
    //MARK: - setupAdultDropDown
    func setupAdultDropDown() {
        
        adultDropdown.dataSource = adult18Array
        adultDropdown.direction = .bottom
        adultDropdown.backgroundColor = .WhiteColor
        adultDropdown.anchorView = self.adultView
        adultDropdown.bottomOffset = CGPoint(x: 0, y: adultView.frame.size.height + 10)
        adultDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.adultlbl.text = item
            self?.adultlbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnAdultBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupChildDropDown
    func setupChildDropDown() {
        
        childDropdown.dataSource = child2_7Array
        childDropdown.direction = .bottom
        childDropdown.backgroundColor = .WhiteColor
        childDropdown.anchorView = self.childView
        childDropdown.bottomOffset = CGPoint(x: 0, y: childView.frame.size.height + 10)
        childDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.childlbl.text = item
            self?.childlbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnChildBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupChildDropDown
    func setupTerminalDropDown() {
        
        terminalDropdown.dataSource = terminalArray
        terminalDropdown.direction = .bottom
        terminalDropdown.backgroundColor = .WhiteColor
        terminalDropdown.anchorView = self.terminalView
        terminalDropdown.bottomOffset = CGPoint(x: 0, y: terminalView.frame.size.height + 10)
        terminalDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.terminalTF.text = item
            self?.terminalTF.textColor = .AppLabelColor
            self?.delegate?.didTapOnTerminalBtnAction(cell: self!)
            
        }
    }
    
    
    
    
    
    
}




extension ExploreLeadPassengerTVCell {
    
    
    //MARK: - showdebDatePicker
    func showdebDatePicker() {
        // Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.maximumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        depDateTF.inputAccessoryView = toolbar
        depDateTF.inputView = depDatePicker
    }
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        depDateTF.text = formatter.string(from: depDatePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    //MARK: - Dep Time Picker
    func showdepTimePicker(){
        //Formate Date
        depTimePicker.datePickerMode = .time
        depTimePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        depTimeTF.inputAccessoryView = toolbar
        depTimeTF.inputView = depTimePicker
        
    }
    
    @objc func doneTimePicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm" // Customize the date format as needed
        
        depTimeTF.text = dateFormatter.string(from: depTimePicker.date)
        //   depTimeView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker(){
        delegate?.cancelTimePicker(cell: self)
    }
    
    
}



extension ExploreLeadPassengerTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
    
    
}

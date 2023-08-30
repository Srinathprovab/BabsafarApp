//
//  InsurenceFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit
import DropDown

protocol InsurenceFlightDetailsTVCellDelegate {
    func doneTimePicker(cell:InsurenceFlightDetailsTVCell)
    func cancelTimePicker(cell:InsurenceFlightDetailsTVCell)
    func editingTextField(tf:UITextField)
}

class InsurenceFlightDetailsTVCell: TableViewCell, AirlineListViewModelDelegate {
    
    
    @IBOutlet weak var fromAirportNamelbl: UILabel!
    @IBOutlet weak var toAirportNamelbl: UILabel!
    @IBOutlet weak var pnrTF: UITextField!
    @IBOutlet weak var depAirlinelbl: UILabel!
    @IBOutlet weak var arrivalAirlinelbl: UILabel!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var arrivalDatelbl: UILabel!
    @IBOutlet weak var depTimeTF: UITextField!
    @IBOutlet weak var arrivalTimeTF: UITextField!
    @IBOutlet weak var pnrView: BorderedView!
    @IBOutlet weak var depView: BorderedView!
    @IBOutlet weak var arrivalView: BorderedView!
    @IBOutlet weak var depTimeView: BorderedView!
    @IBOutlet weak var arrivalTimeView: BorderedView!
    
    let depratureAirlineDropdown = DropDown()
    let arrivalAirlineDropdown = DropDown()
    let depTimePicker = UIDatePicker()
    let arrivalTimePicker = UIDatePicker()
    var arilineList = [AirlineListModel]()
    var countryNames = [String]()
    var vm:AirlineListViewModel?
    var delegate:InsurenceFlightDetailsTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        vm = AirlineListViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        fromAirportNamelbl.text = searchInputs?.from ?? ""
        toAirportNamelbl.text = searchInputs?.to ?? ""
        depDatelbl.text = searchInputs?.depature ?? ""
        arrivalDatelbl.text = searchInputs?.arrival ?? ""
        
        DispatchQueue.main.async {
            self.callAPI()
        }
    }
    
    
    func setupUI() {
        setupTextField(txtField: pnrTF, tag: 55)
        setupTextField(txtField: depTimeTF, tag: 2)
        setupTextField(txtField: arrivalTimeTF, tag: 3)
        showdepTimePicker()
        showArrivalTimePicker()
        setupdepratureAirlineDropDown()
        setuparrivalAirlineDropdown()
    }
    
    
    
    func setupTextField(txtField:UITextField,tag:Int) {
        txtField.tag = tag
        txtField.setLeftPaddingPoints(5)
        txtField.delegate = self
        txtField.textColor = .AppLabelColor
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 12)
        txtField.addTarget(self, action: #selector(editingTextField(textField:)), for: .editingChanged)
    }
    
    @objc func editingTextField(textField: UITextField) {
        switch textField {
        case pnrTF:
            pnrView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
        default:
            break
        }
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    
    @IBAction func didTapOnSelectDepartureAirlineButAction(_ sender: Any) {
        depratureAirlineDropdown.dataSource = countryNames
        depratureAirlineDropdown.show()
    }
    
    
    
    @IBAction func didTapOnSelectArrivalAirlineButAction(_ sender: Any) {
        arrivalAirlineDropdown.dataSource = countryNames
        arrivalAirlineDropdown.show()
    }
    
}


extension InsurenceFlightDetailsTVCell {
    
    
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
    
    func showArrivalTimePicker(){
        //Formate Date
        arrivalTimePicker.datePickerMode = .time
        arrivalTimePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        arrivalTimeTF.inputAccessoryView = toolbar
        arrivalTimeTF.inputView = arrivalTimePicker
        
    }
    
    @objc func doneTimePicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" // Customize the date format as needed
        
        if depTimeTF.isFirstResponder {
            depTimeTF.text = dateFormatter.string(from: depTimePicker.date)
            depTimeView.layer.borderColor = UIColor.AppBorderColor.cgColor
        } else if arrivalTimeTF.isFirstResponder {
            arrivalTimeTF.text = dateFormatter.string(from: arrivalTimePicker.date)
            arrivalTimeView.layer.borderColor = UIColor.AppBorderColor.cgColor
        }
    
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker(){
        delegate?.cancelTimePicker(cell: self)
    }
    
    
    
}


extension InsurenceFlightDetailsTVCell {
    
    
    func callAPI(){
        vm?.CALL_AIRLINE_LIST_API(dictParam: [:])
    }
    
    func airlineList(response: [AirlineListModel]) {
        arilineList = response
        countryNames.removeAll()
        
        arilineList.forEach { i in
            countryNames.append(i.label ?? "")
        }
    }
    
    
    func setupdepratureAirlineDropDown() {
        
        depratureAirlineDropdown.direction = .bottom
        depratureAirlineDropdown.backgroundColor = .WhiteColor
        depratureAirlineDropdown.anchorView = self.depView
        depratureAirlineDropdown.bottomOffset = CGPoint(x: 0, y: self.depView.frame.size.height + 10)
        depratureAirlineDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.depAirlinelbl.text = self?.countryNames[index] ?? ""
            self?.depView.layer.borderColor = UIColor.AppBorderColor.cgColor
        }
        
    }
    
    func setuparrivalAirlineDropdown() {
        
        arrivalAirlineDropdown.direction = .bottom
        arrivalAirlineDropdown.backgroundColor = .WhiteColor
        arrivalAirlineDropdown.anchorView = self.arrivalView
        arrivalAirlineDropdown.bottomOffset = CGPoint(x: 0, y: self.arrivalView.frame.size.height + 10)
        arrivalAirlineDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.arrivalAirlinelbl.text = self?.countryNames[index] ?? ""
            self?.arrivalView.layer.borderColor = UIColor.AppBorderColor.cgColor
        }
        
    }
    
    
}

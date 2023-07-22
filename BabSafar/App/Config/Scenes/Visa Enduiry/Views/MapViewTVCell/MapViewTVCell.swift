//
//  MapViewTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/02/23.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewTVCellDelegate {
    func didTapOnMapImgBtnAction(cell:MapViewTVCell)
}


class MapViewTVCell: TableViewCell,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var holderView: UIView!
    
    
    var delegate:MapViewTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnMapImgBtnAction(_ sender: Any) {
        delegate?.didTapOnMapImgBtnAction(cell: self)
    }
    
}

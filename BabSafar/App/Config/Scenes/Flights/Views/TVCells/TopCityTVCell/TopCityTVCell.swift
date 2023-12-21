//
//  TopCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class TopCityTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citysCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
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
        super.prepareForReuse()
        
        stopAutoScroll()
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        if cellInfo?.key == "flights" {
            if topFlightDetails.count == 0 {
                citysCV.setEmptyMessage("No Data Found")
            }else {
                citysCV.restore()
                itemCount = topFlightDetails.count
                startAutoScroll()
            }
        }else {
            if topHotelDetails.count == 0 {
                citysCV.setEmptyMessage("No Data Found")
            }else {
                citysCV.restore()
                itemCount = topHotelDetails.count
                startAutoScroll()
            }
        }
        
        
        
        citysCV.reloadData()
        
    }
    
    
    func setupUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .AppHolderViewColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 20), align: .left)
        setupCV()
    }
    
    func setupCV() {
        let nib = UINib(nibName: "TopCityCVCell", bundle: nil)
        citysCV.register(nib, forCellWithReuseIdentifier: "cell")
        citysCV.delegate = self
        citysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        citysCV.collectionViewLayout = layout
        citysCV.backgroundColor = .clear
        citysCV.layer.cornerRadius = 4
        citysCV.clipsToBounds = true
        citysCV.showsHorizontalScrollIndicator = false
        citysCV.backgroundColor = .AppHolderViewColor
        citysCV.bounces = false
    }
    
    
    // MARK: - Auto Scrolling
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
         
        
        guard itemCount > 0 else {
            return // No items in the collection view
        }
        
        let currentIndexPaths = citysCV.indexPathsForVisibleItems.sorted()
        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
        
        var nextIndexPath: IndexPath
        
        if lastIndexPath.item == itemCount - 1 {
            nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
        } else {
            nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
        }
        
        if nextIndexPath.item >= itemCount {
            nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
        }
        
        citysCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }

    
    
}


extension TopCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellInfo?.key == "flights" {
            return topFlightDetails.count
        }else {
            return topHotelDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopCityCVCell {
            
            if cellInfo?.key == "flights" {
                let data = topFlightDetails[indexPath.row]
                
                cell.cityImage.sd_setImage(with: URL(string: data.topFlightImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.cityNamelbl.text = "\(data.to_city_name ?? "")"
                
                
            } else {
                
                let data = topHotelDetails[indexPath.row]
                cell.cityImage.sd_setImage(with: URL(string: data.topHotelImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.cityNamelbl.text = "\(data.country ?? "")"
                
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TopCityCVCell {
            var userinfo = [String:Any]()
            if cellInfo?.key == "flights" {
                userinfo.removeAll()
                userinfo["trip_type"] = topFlightDetails[indexPath.row].trip_type ?? ""
                userinfo["fromFlight"] = topFlightDetails[indexPath.row].fromFlight ?? ""
                userinfo["from_city"] = topFlightDetails[indexPath.row].from_city ?? ""
                userinfo["toFlight"] = topFlightDetails[indexPath.row].toFlight ?? ""
                userinfo["to_city"] = topFlightDetails[indexPath.row].to_city ?? ""
                userinfo["travel_date"] = topFlightDetails[indexPath.row].travel_date ?? ""
                userinfo["return_date"] = topFlightDetails[indexPath.row].return_date ?? ""
                userinfo["airline_class"] = topFlightDetails[indexPath.row].airline_class ?? ""
                userinfo["from_city_name"] = topFlightDetails[indexPath.row].from_city_name ?? ""
                userinfo["to_city_name"] = topFlightDetails[indexPath.row].to_city_name ?? ""
                userinfo["from_city_loc"] = topFlightDetails[indexPath.row].from_city_loc ?? ""
                userinfo["to_city_loc"] = topFlightDetails[indexPath.row].to_city_loc ?? ""
                
                NotificationCenter.default.post(name: NSNotification.Name("topcity"), object: nil,userInfo: userinfo)
            }else {
                userinfo.removeAll()
                userinfo["city"] = topHotelDetails[indexPath.row].country ?? ""
                userinfo["hotel_code"] = topHotelDetails[indexPath.row].city ?? ""
                userinfo["check_in"] = topHotelDetails[indexPath.row].check_in ?? ""
                userinfo["check_out"] = topHotelDetails[indexPath.row].check_out ?? ""
                NotificationCenter.default.post(name: NSNotification.Name("tophotel"), object: nil,userInfo: userinfo)
                print("Hotel")
            }
        }
    }
    
}


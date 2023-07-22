//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
        return vc
    }
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var annotationtitle = String()
    var lat = Double()
    var long = Double()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop location updates
        locationManager.stopUpdatingLocation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start location updates
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        locationSetup()
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        self.holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Map View"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        annotation.title = annotationtitle
     //   annotation.image = UIImage(named: "loc")
        
    }
    
    
    func locationSetup() {
        locationManager.requestWhenInUseAuthorization()
        // Request location authorization
        locationManager.requestWhenInUseAuthorization()
        
        // Configure map view
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}


extension MapViewVC:CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Update the map view with the current location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // Add the annotation to the map view
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            if let customAnnotation = annotation as? CustomAnnotation {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                imageView.image = customAnnotation.image
                annotationView?.leftCalloutAccessoryView = imageView
            }
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    
    
}


class CustomAnnotation: MKPointAnnotation {
    var image: UIImage?
}

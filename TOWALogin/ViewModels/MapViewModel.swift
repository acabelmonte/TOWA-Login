//
//  MapViewModel.swift
//  TOWALogin
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import Foundation
import CoreLocation
import CoreFoundation
import MapKit

class MapViewModel: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager?
    private var userLocation: CLLocationCoordinate2D?
    private var myLocation: CLLocationCoordinate2D?
    private var annotations = [MKPointAnnotation]()
    let numberFormatter = NumberFormatter()
    var completionBlock: () -> Void = {}
    
    // MARK: - Custom getter/setter
    private var _user = User(data: [String: Any]())
    var user: User {
        get {
            return _user
        }
        set {
            _user = newValue
            
            if let geo = _user.address?.geo {
                userLocation = CLLocationCoordinate2D(latitude: geo.lat, longitude: geo.lng)
            }
        }
    }
    
    // MARK: - Public methods
    func getAnnotations(completion: @escaping ([MKPointAnnotation]) -> Void) {
        requestLocationAccess()
        
        completionBlock = {
            if let loc = self.userLocation {
                let annotation = MKPointAnnotation()
                annotation.coordinate = loc
                annotation.title = self.user.name
                annotation.subtitle = "\(loc.latitude), \(loc.longitude)"
                self.annotations.append(annotation)
            }
            
            DispatchQueue.main.async {
                completion(self.annotations)
            }
        }
    }
    
    func getDistance() -> String {
        if let myLocation = myLocation, let userLocation = userLocation {
            let loc1 = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
            let loc2 = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let distance = loc1.distance(from: loc2) / 1000.0
            
            return formatDistance(distance)
        }
        else {
            return "Unable to get distance"
        }
    }
    
    // MARK: - Internal methods
    private func requestLocationAccess() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func formatDistance(_ distance: Double) -> String {
        numberFormatter.numberStyle = .decimal
        
        if let formattedDistance = numberFormatter.string(from: NSNumber(value: distance)) {
            return "\(formattedDistance) km"
        }
        else {
            return "Unable to get distance"
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            myLocation = locationManager?.location?.coordinate
        }
        
        if let loc = myLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = loc
            annotation.title = "You are here"
            annotation.subtitle = "\(loc.latitude), \(loc.longitude)"
            annotations.append(annotation)
        }
        
        completionBlock()
    }
    
}

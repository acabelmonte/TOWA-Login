//
//  MapViewController.swift
//  TOWALogin
//
//  Created by Arthur Christopher Belmonte on 7/10/22.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    private let viewModel = MapViewModel()
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allowAutoRotate = true
        viewModel.user = user!
        viewModel.getAnnotations { annotations in
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            self.distanceLabel.text = self.viewModel.getDistance()
        }
    }
    
    // MARK: - Button tap methods
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

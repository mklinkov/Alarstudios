//
//  DetailViewController.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation
import UIKit
import MapKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var presenter: DetailPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension DetailViewController: DetailPresenterOutput {
    
    func showItemDetail(_ model: DetailItemModel) {
        nameLabel.text = model.name
        countryLabel.text = model.country
        positionLabel.text = model.locationString
        DispatchQueue.main.async {
            /// в main.async чтобы не притормаживал UI  при открытии контроллера
            self.showMapPoint(model.pointLocation, name: model.name)
        }
    }
    
    private func showMapPoint(_ pointLocation: CLLocationCoordinate2D, name: String ) {
        
        let annotations = MKPointAnnotation()
        
        annotations.title = name
        annotations.coordinate = pointLocation
        mapView.addAnnotation(annotations)
        
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegion(center: pointLocation, latitudinalMeters: CLLocationDistance(exactly: regionRadius)!, longitudinalMeters: CLLocationDistance(exactly: regionRadius)!)
        
        mapView.setRegion(coordinateRegion, animated: false)
    }
}

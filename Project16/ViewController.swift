//
//  ViewController.swift
//  Project16
//
//  Created by Luciene Ventura on 15/05/21.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275), info: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude:48.8567, longitude: 2.3508), info: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change Map", style: .plain, target: self, action: #selector(changeMap))
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func changeMap() {
        let ac = UIAlertController(title: "Change Map", message: nil, preferredStyle: .alert)
        let satelite = UIAlertAction(title: "Satellite", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satellite
        }
        
        let standart = UIAlertAction(title: "Map", style: .default) { [weak self] _ in
            self?.mapView.mapType = .standard
        }
        
        ac.addAction(standart)
        ac.addAction(satelite)
        present (ac, animated: true)
        
        
        }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        let annotationViewCollor = annotationView as? MKPinAnnotationView
        annotationViewCollor?.pinTintColor = .yellow
        return annotationViewCollor
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        if let wikiInfo = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            wikiInfo.selectedCapital = capital.info
            navigationController?.pushViewController(wikiInfo, animated: true)
        }
    
    }


}


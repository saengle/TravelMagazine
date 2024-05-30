//
//  RestauranctMapViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/30/24.
//

import MapKit
import UIKit


class RestauranctMapViewController: UIViewController{
    
    let mapView = MKMapView()
    var annotations: [MKAnnotation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(navDrawerClicked))
        navigationItem.title = "테스토"
        navigationController?.isNavigationBarHidden = false
        configureUI()
        // 중심값(필수): 위, 경도 37.5177783, 126.8863443
        let center = CLLocationCoordinate2D(latitude: 37.5177783,
                                            longitude: 126.8863443)
        

        // center를 중심으로 지정한 미터(m)만큼의 영역을 보여줌
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)

        mapView.setRegion(region, animated: true)
//        addWholeAnotation()
        addAnnotations(keyWord: "한식")
    }
    
    
}

extension RestauranctMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    
    private func configureUI() {
        addSubViews()
        setConstraints()
    }
    
    private func addSubViews(){
        
        self.view.addSubview(mapView)
    }
    
    private func setConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   NSLayoutConstraint(item: mapView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                   NSLayoutConstraint(item: mapView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                   NSLayoutConstraint(item: mapView, attribute: .width, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: 1.0, constant: 0.0),
                   NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 1.0, constant: 0.0)
               ])
    }

    private func addWholeAnotation() {
        annotations.removeAll()
        for i in RestaurantList.restaurantArray {
            let annotation = MKPointAnnotation()
            annotation.title = "\(i.name)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotations.append(annotation)
            mapView.addAnnotations(annotations)
        }
    }
    
    private func addAnnotations(keyWord: String) {
        annotations.removeAll()
        var tempRestauranct: [Restaurant] = []
        tempRestauranct.append(contentsOf: RestaurantList.restaurantArray.filter{$0.category.contains(keyWord)})
        for i in tempRestauranct {
            let annotation = MKPointAnnotation()
            annotation.title = "\(i.name)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotations.append(annotation)
            mapView.addAnnotations(annotations)
        }
    }
    
    @objc func navDrawerClicked() {
        
    }
    
}

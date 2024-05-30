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
    var wholeAnnotations: [MKAnnotation] = []
    var annotations: [MKAnnotation] = []
    // category ["한식", "경양식", "양식", "중식", "일식", "카페", "모두"]
    var category = ["모두", "한식", "양식", "중식", "일식", "카페"]
//    let buttonsCV: UICollectionView = {
//        let view = UICollectionView()
//       
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(navDrawerClicked))
        navigationItem.title = "테스토"
        navigationController?.isNavigationBarHidden = false
        configureUI()
        // 중심값(필수): 위, 경도 37.5177783, 126.8863443
   

        
//        addWholeAnotation()
//        addAnnotations(keyWord: "한식")
//        buttonsCV.delegate = self
//        buttonsCV.dataSource = self
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
            wholeAnnotations.append(annotation)
            annotations.append(annotation)
            mapView.addAnnotations(wholeAnnotations)
        }
    }
    
    private func addAnnotations(keyWord: String) {
        // category ["한식", "경양식", "양식", "중식", "일식", "카페", "모두"]
        mapView.removeAnnotations(annotations)
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
    
     func addFirstAnnotation(keyWord: String) {
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        var tempRestauranct: [Restaurant] = []
        tempRestauranct.append(contentsOf: RestaurantList.restaurantArray.filter{$0.name == keyWord})
         
         let center = CLLocationCoordinate2D(latitude: tempRestauranct[0].latitude,
                                             longitude: tempRestauranct[0].longitude)
                  // center를 중심으로 지정한 미터(m)만큼의 영역을 보여줌
         let region = MKCoordinateRegion(center: center,
                                         latitudinalMeters: 500 ,
                                         longitudinalMeters: 500)
         mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.title = "\(tempRestauranct[0].name)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: tempRestauranct[0].latitude, longitude: tempRestauranct[0].longitude)
            annotations.append(annotation)
            
            mapView.addAnnotations(annotations)
        
    }
    
    @objc func navDrawerClicked() {
        //1. alert 생성
        let alert = UIAlertController(title: "카테고리를 골라주세요", message: "", preferredStyle: .actionSheet)
        //2. action 선언 필요시 handler 사용.
        let all = UIAlertAction(title: "모두 보기", style: .default, handler: {_ in self.addWholeAnotation()})
        let korean = UIAlertAction(title: "한식", style: .default, handler: {_ in self.addAnnotations(keyWord: "한식")})
        let yangsik = UIAlertAction(title: "양식", style: .default, handler: {_ in self.addAnnotations(keyWord: "양식")})
        let chinese = UIAlertAction(title: "중식", style: .default, handler: {_ in self.addAnnotations(keyWord:"중식")})
        let japanese = UIAlertAction(title: "일식", style: .default, handler: {_ in self.addAnnotations(keyWord: "일식")})
        let cafe = UIAlertAction(title: "카페", style: .default, handler: {_ in self.addAnnotations(keyWord: "카페")})
        
        //3. alert에 action 등록
        alert.addAction(all)
        alert.addAction(korean)
        alert.addAction(yangsik)
        alert.addAction(chinese)
        alert.addAction(japanese)
        alert.addAction(cafe)
        
        //4. 띄우기
        present(alert, animated: true)
    }
}
//
//extension RestauranctMapViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        return UICollectionViewCell()
//    }
//    
//    
//    
//}

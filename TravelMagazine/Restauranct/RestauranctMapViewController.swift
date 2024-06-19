//
//  RestauranctMapViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/30/24.
//
import CoreLocation
import MapKit
import UIKit


class RestauranctMapViewController: UIViewController{
    
    let mapView = MKMapView()
    var wholeAnnotations: [MKAnnotation] = []
    var annotations: [MKAnnotation] = []
    
    var category = ["모두", "한식", "양식", "중식", "일식", "카페"]

    let locationManager = CLLocationManager()
    lazy var myLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(navDrawerClicked)), UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(myLocationButtonClicked))]
        navigationItem.title = "테스토"
        navigationController?.isNavigationBarHidden = false
        configureUI()
    
        locationManager.delegate = self
        checkDeviceLocationAuthorization()
    }
}

extension RestauranctMapViewController {
    // 1) 사용자에게 권한 요청을 하기 위해, ios위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        // 아래 메서드가 타입메서드 (Static func) -> class func 으로 보여줌
        
        let myQueue = DispatchQueue(label:"myOwnQueue")
        myQueue.async {
          if CLLocationManager.locationServicesEnabled() {
              self.checkCurrentLocationAuthorization()
          } else { // 위치서비스가 꺼져있는 상태. 이니 알려줘서 켜도록 유도해야함
          }
        }
    }
    // 2) 현재 사용자 위치 권한 상태 확인
    func checkCurrentLocationAuthorization() {
        var status: CLAuthorizationStatus = locationManager.authorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        switch status {
        case .notDetermined: // 정해져 있지 않음 -> 권한 설정버튼 띄워줌
            //정확도
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //권한 요청
            locationManager.requestWhenInUseAuthorization()
        case .denied: break // 권한 거절 누른 상탱 ios 설정창으로 이동하라고 알려 줄 수 밖에 없음.
        case .authorizedWhenInUse: //위치 정보 알려달라고 로직 구성할 수 있음
            // 위치정보 달라고 요청
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
    }
    // 매개변수 타입이 저런 이유는 coordinate 자체가 저런 타입입.
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        //맵뷰, 맵뷰에 어노테이션.
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func myLocationButtonClicked() {
        setRegionAndAnnotation(center: myLocation)
    }
}

// MARK:   3. 위치관련 프로토콜 선언: CLLocationManagerDelegate
extension RestauranctMapViewController: CLLocationManagerDelegate {

    // MARK:  5. 사용자 위치를 성공적으로 가지고 온 경우
    // 코드 구성에 따라 여러번 호출이 될 수도 있다.
    // didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            myLocation = coordinate
            // 권한 허용시 본인 위치로 맵 이동
            setRegionAndAnnotation(center: coordinate)
        }
        //startUpdatingLocation을 했으면 더이상 위치를 안받아도 되는 시점에서 stop을 해줘야만 함 ! 안하면 계~~~~~~~~~~속 하고있음
//        locationManager.stopUpdatingLocation() // 필요한 시점에 사용하면 사용자 위치 업데이트를 그만둠.
    }
    // MARK:  6. 사용자 위치를 가지고 오지 못한경우
    // didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    // MARK:  7. 사용자의 권한 상태가 변경된경우 (iOS14) + 인스턴스가 생성이 될 때도 호출이 된다.
    // -> 뷰 디드 로드 등의 다른 시점들에서 굳이 호출할 필요가 없음 ! 인스턴스 생성되면 알아서 뜨니까. => 만약에 굳이 뷰 생성시 호출하면 이상하게 두번뜸 ;
    // 사용자가 허용을 했었는데, 추후 직접 아이폰 설정에서 허용권한을 변경(거부)한 경우. or 한번허용 이여서 잘 쓰고 껐다 켰을때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }
    // ios14 부터 deprecate 됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOs14-")
    }
}


extension RestauranctMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
       
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
        
        let center = CLLocationCoordinate2D(latitude: 37.5177783,
                                            longitude: 126.8863443)
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 750 ,
                                        longitudinalMeters: 750)
        mapView.setRegion(region, animated: true)
    }
}


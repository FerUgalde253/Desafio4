//
//  ViewController.swift
//  ClimaApp
//
//  Created by Fernando Ugalde on 11/09/23.
//

import UIKit
import Lottie

class ClimaViewController: UIViewController {
    //Status
    var weatherSatus: String = "sun.max.fill"
    var actualTemp: String = "25 °C"
    //Labels
    let cityName: UILabel = UILabel()
    let cityID: UILabel = UILabel()
    let zipCode: UILabel = UILabel()
    let temp: UILabel = UILabel()
    //TextFields
    let cityBrowser: UITextField = UITextField()
    //Images
    let climaStatus: UIImageView = UIImageView()
    let ownLocation: UIImageView = UIImageView()
    let searchLocation: UIImageView = UIImageView()
    let earth: UIImageView = UIImageView()
    //UIViews
    let locationContainer: UIView = UIView()
    //Animations Vars
    var climaStatusAnimate = NSLayoutConstraint()
    var earthAnimate = NSLayoutConstraint()
    let gradientLayer = CAGradientLayer()
    //Specials
    var tempBlue: CGFloat = 0.0
    var tempRed: CGFloat = 1.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        createGradientLayer()
        gestures()
        climeStatusAnimation()
        animateGradientLocations()
        
        // Do any additional setup after loading the view.
    }
    
    func uiInit(){
        locationContainer.backgroundColor = UIColor.clear
        locationContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationContainer)
        ////////////////////////////////////////////////////
        cityName.textAlignment = .center
        cityName.textColor = UIColor.black
        cityName.font = UIFont(name: "Arial", size: 18)
        cityName.text = "Guadalajara"
        cityName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityName)
        ////////////////////////////////////////////////////
        cityID.textAlignment = .center
        cityID.textColor = UIColor.black
        cityID.font = UIFont(name: "Arial", size: 18)
        cityID.text = "GDL"
        cityID.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityID)
        ////////////////////////////////////////////////////
        zipCode.textAlignment = .center
        zipCode.textColor = UIColor.black
        zipCode.font = UIFont(name: "Arial", size: 18)
        zipCode.text = "45527"
        zipCode.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zipCode)
        ////////////////////////////////////////////////////
        temp.textAlignment = .center
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "Arial", size: 100)
        temp.text = actualTemp
        temp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temp)
        ////////////////////////////////////////////////////
        climaStatus.image = UIImage(systemName: weatherSatus)
        climaStatus.tintColor = UIColor.black
        climaStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(climaStatus)
        ////////////////////////////////////////////////////
        ownLocation.image = UIImage(systemName: "location.circle")
        ownLocation.tintColor = UIColor.black
        ownLocation.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.addSubview(ownLocation)
        ////////////////////////////////////////////////////
        searchLocation.image = UIImage(systemName: "location.magnifyingglass")
        searchLocation.tintColor = UIColor.black
        searchLocation.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.addSubview(searchLocation)
        ////////////////////////////////////////////////////
        cityBrowser.textAlignment = .left
        cityBrowser.placeholder = " Select country"
        cityBrowser.layer.cornerRadius = 10
        cityBrowser.layer.borderColor = UIColor.black.cgColor
        cityBrowser.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.addSubview(cityBrowser)
        ////////////////////////////////////////////////////
        earth.image = UIImage(named: "tierra")
        earth.alpha = 0
        earth.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(earth)
        
        //Constrains to animate
        climaStatusAnimate = climaStatus.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        earthAnimate = earth.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        // General Constrains
        [locationContainer,cityName,cityID,zipCode,temp].forEach { view in NSLayoutConstraint.activate([view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])}
        [locationContainer,cityName,cityID,zipCode,temp].forEach { view in NSLayoutConstraint.activate([view.widthAnchor.constraint(equalTo: self.view.widthAnchor)])}
       
        // Heigh constrains
        NSLayoutConstraint.activate([
            locationContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            locationContainer.heightAnchor.constraint(equalToConstant: 40),
            cityName.topAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: 25),
            climaStatus.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 25),
            climaStatus.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            temp.topAnchor.constraint(equalTo: climaStatus.bottomAnchor, constant: 25),
            cityID.topAnchor.constraint(equalTo: temp.bottomAnchor, constant: 25),
            zipCode.topAnchor.constraint(equalTo: cityID.bottomAnchor, constant: 25),
            earth.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 25),
            earth.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -100)
        ])
        // Width constrains
        NSLayoutConstraint.activate([
            climaStatus.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            earth.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100)
        ])
        // Container constrains
        [ownLocation,searchLocation,cityBrowser,cityBrowser].forEach { view in NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: locationContainer.topAnchor)])}
        [ownLocation,searchLocation,cityBrowser,cityBrowser].forEach { view in NSLayoutConstraint.activate([view.heightAnchor.constraint(equalTo: locationContainer.heightAnchor)])}
        
        NSLayoutConstraint.activate([
            climaStatusAnimate,
            earthAnimate,
            ownLocation.leadingAnchor.constraint(equalTo: locationContainer.leadingAnchor, constant: 25),
            ownLocation.widthAnchor.constraint(equalToConstant: 40),
            searchLocation.rightAnchor.constraint(equalTo: locationContainer.rightAnchor, constant: -25),
            searchLocation.widthAnchor.constraint(equalToConstant: 40),
            cityBrowser.centerXAnchor.constraint(equalTo: locationContainer.centerXAnchor),
            cityBrowser.leadingAnchor.constraint(equalTo: ownLocation.trailingAnchor, constant: 25),
            //cityBrowser.rightAnchor.constraint(equalTo: searchLocation.leadingAnchor, constant: -25)
        ])
    }
    func gestures(){
        let climeStatusTap = UITapGestureRecognizer(target: self, action: #selector(climeStatusRotate(tapGestureRecognizer:)))
        climaStatus.isUserInteractionEnabled = true
        climeStatusTap.numberOfTapsRequired = 1
        climaStatus.addGestureRecognizer(climeStatusTap)
        
        let ownLocationTap = UITapGestureRecognizer(target: self, action: #selector(ownLocationSearching(tapGestureRecognizer:)))
        ownLocation.isUserInteractionEnabled = true
        ownLocationTap.numberOfTapsRequired = 1
        ownLocation.addGestureRecognizer(ownLocationTap)
        
        let SwipeArriba = UISwipeGestureRecognizer()
        let SwipeAbajo = UISwipeGestureRecognizer()
        SwipeArriba.direction = .up
        SwipeAbajo.direction = .down
        view.addGestureRecognizer(SwipeArriba)
        view.addGestureRecognizer(SwipeAbajo)
        SwipeArriba.addTarget(self, action: #selector(Swipe(sender:)))
        SwipeAbajo.addTarget(self, action: #selector(Swipe(sender:)))
    }
    
    func climeStatusAnimation(){
        UIView.animate(withDuration: 6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.25) {
            self.climaStatus.transform = CGAffineTransform(rotationAngle: .pi/2)
        }completion: { _ in
            self.climaStatus.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    func ownLocationAnimation(){
        UIView.animate(withDuration: 3) {
            self.climaStatus.alpha = 0
            self.temp.alpha = 0
            self.cityName.alpha = 0
            self.cityID.alpha = 0
            self.zipCode.alpha = 0
            self.earth.alpha = 1
        } completion: { _ in
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                    rotationAnimation.fromValue = 0.0
                    rotationAnimation.toValue = .pi * 2.0
                    rotationAnimation.duration = 5.0
            self.earth.layer.add(rotationAnimation, forKey: "earthRotation")
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5){
                UIView.animate(withDuration: 3) {
                    self.climaStatus.alpha = 1
                    self.temp.alpha = 1
                    self.cityName.alpha = 1
                    self.cityID.alpha = 1
                    self.zipCode.alpha = 1
                    self.earth.alpha = 0
                }
            }
        }
    }
    
    func createGradientLayer() {
        // Define los colores y los puntos del gradiente
        let colors: [CGColor] = [UIColor.blue.cgColor, UIColor.red.cgColor]
        let startPoint = CGPoint(x: 0.0, y: 1.0)
        let endPoint = CGPoint(x: 0.0, y: 0.0)
        let locations: [NSNumber] = [0.0, 1.0]
        
        // Asigna sus atributos al gradient
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.opacity =  0.3
        
        // Configura la posición y el tamaño del gradiente
        gradientLayer.frame = view.bounds
        
        // Agrega la capa de gradiente a la vista
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func animateGradientLocations() {
        // Crea una animación CABasicAnimation para animar el cambio de ubicaciones
        let animation = CABasicAnimation(keyPath: "locations")
        //animation.fromValue = gradientLayer.locations
        animation.fromValue = gradientLayer.locations
        animation.toValue = [tempBlue , 0.0] // Valor final
        animation.duration = 1.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: "locationsAnimation")
    }
    
    @objc func climeStatusRotate(tapGestureRecognizer: UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        climeStatusAnimation()
    }
    @objc func ownLocationSearching(tapGestureRecognizer: UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        ownLocationAnimation()
    }
    @objc func Swipe(sender: UISwipeGestureRecognizer){
   
        switch sender.direction {
        case .up:
            if tempBlue >= 0.0 {
                tempBlue -= 0.20000
                tempRed += 0.20000
            }else {
                tempBlue = 0.00000
                tempRed = 1.00000
            }
        case .down:
            if tempBlue <= 1.0 {
                tempBlue += 0.20000
                tempRed -= 0.20000
            }else{
                tempBlue = 1.00000
                tempRed = 0.00000
            }
        default:
            print("default")
            tempBlue = 0.00000
            tempRed = 1.00000
        }
        animateGradientLocations()
        print("Azul: \(tempBlue)")
        print("Red: \(tempRed)")
    }
}


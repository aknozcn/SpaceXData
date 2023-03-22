//
//  Loading.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//
import UIKit

class Loading {
    
    public static let shared = Loading()
    
    private var containerView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    func show() {
        let window = UIApplication.shared.keyWindowInConnectedScenes
        if let window = window {
            containerView.frame = window.bounds
            containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            activityIndicator.center = CGPoint(x: containerView.bounds.width / 2, y: containerView.bounds.height / 2)
            containerView.addSubview(activityIndicator)
            
            window.addSubview(containerView)
        }
        
        activityIndicator.startAnimating()
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}

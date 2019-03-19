//
//  Spinner.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/19/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import UIKit

class Spinner {
    
    static let instance = Spinner()
    
    private var container: UIView = UIView()
    private var loadingView: UIView = UIView()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private init() {}
    
    func showActivityIndicator(in view: UIView) {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor(rgb: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(rgb: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        let width = loadingView.frame.size.width / 2
        let height = loadingView.frame.size.height / 2
        activityIndicator.center = CGPoint(x: width, y: height)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
}

extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        guard 0...255 ~= red && 0...255 ~= green && 0...255 ~= blue else {
            return nil
        }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init?(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF, alpha: alpha
        )
    }
}

//
//  LoadingViewable.swift
//  EvaPharmaTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit

protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension loadingViewable where Self: UIViewController {
    func startAnimating() {
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.layer.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                let animation = {item.alpha = 0 }
                UIView.animate(withDuration: 0.3, animations: animation) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}

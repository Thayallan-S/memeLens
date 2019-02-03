//
//  UIViewController+AddRemoveChild.swift
//  MemeLens
//
//  Created by Thayallan Srinathan on 2019-02-02.
//  Copyright © 2019 MemeLens. All rights reserved.
//


import UIKit

extension UIViewController {
    func add(childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    func remove(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}

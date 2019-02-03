//
//  AppFlowController.swift
//  MemeLens
//
//  Created by Thayallan Srinathan on 2019-02-02.
//  Copyright © 2019 MemeLens. All rights reserved.
//


import UIKit

class AppFlowController: UIViewController {
    
    private let splashViewController = SplashViewController()
    private let mainViewController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func start() {
        presentSplashViewController()
    }
}

// MARK: - Start Child FlowControllers
extension AppFlowController {
    func presentSplashViewController() {
        add(childController: splashViewController)
        
        let deadline = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            self.dismissSplashViewController()
        })
    }
    
    func dismissSplashViewController() {
        remove(childController: splashViewController)
        
        startGetStarted()
    }
    
    func startGetStarted() {
        add(childController: mainViewController)
    }
}

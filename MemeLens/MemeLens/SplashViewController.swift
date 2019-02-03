//
//  SplashViewController.swift
//  MemeLens
//
//  Created by Thayallan Srinathan on 2019-02-02.
//  Copyright © 2019 MemeLens. All rights reserved.
//


import UIKit
import EasyPeasy
import Then

class SplashViewController: UIViewController {
    
    private let logo = UIImageView().then {
        $0.image = UIImage(named: "whiteLogo")
        $0.contentMode = .scaleAspectFill
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UI.Colors.mainGreen
        
        layoutViews()
    }
}

extension SplashViewController {
    func layoutViews() {
        view.addSubview(logo)
        logo.easy.layout(CenterX(), CenterY(-100))
    }
}

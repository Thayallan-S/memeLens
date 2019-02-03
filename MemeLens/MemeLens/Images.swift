//
//  Images.swift
//  MemeLens
//
//  Created by Thayallan Srinathan on 2019-02-02.
//  Copyright © 2019 MemeLens. All rights reserved.
//

import UIKit
import EasyPeasy
import Then

class Images: UIView {
    
    var photos = ["2scbou","2sgmq1","2sic7g","2siffa","2slodb","2sn4z6"]
    
    private let contentView = UIView()
    
    var image = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    init() {
        super.init(frame: .zero)
        
        setupProperties()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Images {
    func setupProperties() {
        image.image = UIImage(named: photos[0])
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderColor = UI.Colors.mainGreen.cgColor
        contentView.layer.borderWidth = 2.0
    }
    func layoutViews() {
        addSubview(contentView)
        contentView.easy.layout(Left(), Right(), Width(325), Height(500))
        
        contentView.addSubview(image)
        image.easy.layout(Edges())
    }
}

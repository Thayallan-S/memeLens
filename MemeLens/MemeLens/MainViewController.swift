//
//  MainViewController.swift
//  MemeLens
//
//  Created by Thayallan Srinathan on 2019-02-02.
//  Copyright © 2019 MemeLens. All rights reserved.
//

import UIKit
import EasyPeasy
import Then
import ARKit

class MainViewController: UIViewController {
    
    private let header = UIImageView().then {
        $0.image = UIImage(named: "greenLogo")
        $0.contentMode = .scaleAspectFill
    }
    
    let sceneView = ARSCNView()
    
    var counter = 0
    
    var imageNumber: Int = 1
    
    private var images = Images()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UI.Colors.white
        
        imageChanges()
        
        layoutViews()
        
        guard ARFaceTrackingConfiguration.isSupported else { fatalError() }
        sceneView.delegate = self
        
    }
    
    func imageChanges() {
        let deadline = DispatchTime.now() + 10.0
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            if self.imageNumber < 5 {
                self.images.image.image = UIImage(named: self.images.photos[self.imageNumber])
                self.imageNumber = self.imageNumber + 1
                self.imageChanges()
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
}



extension MainViewController {
    
    
    func layoutViews() {
        
        view.addSubview(header)
        header.easy.layout(CenterX(), Top(50))
        
        sceneView.layer.cornerRadius = 10.0

        view.addSubview(sceneView)
        sceneView.easy.layout(Width(325), Height(200), CenterX(), Top(20).to(header))
        
        view.addSubview(images)
        images.easy.layout(CenterX(), Top(20).to(sceneView))
    }
}

extension MainViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let device = sceneView.device else { return nil }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        
        node.geometry?.firstMaterial?.transparency = 0.0
        
        //print("\(faceAnchor.blendShapes.)")
        
        
        //identifyBlinking(faceAnchor: faceAnchor)
        
        
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }
        
        faceGeometry.update(from: faceAnchor.geometry)
        
        for keys in faceAnchor.blendShapes {
            if keys.key.rawValue == "mouthSmile_L" {
                if Double(keys.value) > 0.6  {
                    print("\(counter)")
                    if counter == 200 {
                        print("\(counter)")
                        
                        
                        print("Starting...")
                        let twilioSID = "AC2563fbeafe641619ff90a344c1ca3e22"
                        let twilioSecret = "1972a0ceaee73dabae90ab0ebafef8b1"
                        //Note replace + = %2B , for To and From phone number
                        let fromNumber = "+16473609102"// actual number is +9999999
                        let toNumber = "+16472283352"// actual number is +9999999
                        var val = imageNumber - 1
                        let message = "Check out this meme " + "https://imgflip.com/i/" + "\(images.photos[val])"
                        
                        // Build the request
                        let request = NSMutableURLRequest(url: URL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
                        request.httpMethod = "POST"
                        request.httpBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".data(using: .utf8)
                        
                        // Build the completion block and send the request
                        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                            print("Finished")
                            if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                                // Success
                                print("Response: \(responseDetails)")
                            } else {
                                // Failure
                                print("Error: \(error)")
                            }
                        }).resume()
                       counter = 0
                    }
                    counter = counter + 1
                }
            }
        }
    }
}


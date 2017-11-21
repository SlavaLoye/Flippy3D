//
//  BirdScene.swift
//  FlappyBird3D
//
//  Created by Test on 09.11.17.
//  Copyright © 2017 Test. All rights reserved.
//

import SceneKit

class BirdScene: SCNScene {

    convenience init(create: Bool) {
        self.init()
        
        setupCamera()
        setupScenery()
    }
    
    func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.usesOrthographicProjection = false
        cameraNode.position = SCNVector3(0, 0, 0)
        cameraNode.pivot = SCNMatrix4MakeTranslation(0, 0, -3)
        rootNode.addChildNode(cameraNode)
    }
    
    func setupScenery() {
        
        let groundGeo = SCNBox(width: 4, height: 0.5, length: 0.4, chamferRadius: 0)
        
        let groundNode = SCNNode(geometry: groundGeo)
        
        let emptySand = SCNNode()
        emptySand.addChildNode(groundNode)
        emptySand.position.y = -1.63

        rootNode.addChildNode(emptySand)
        
    }
    
}

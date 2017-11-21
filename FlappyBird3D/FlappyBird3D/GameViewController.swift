//
//  GameViewController.swift
//  FlappyBird3D
//
//  Created by Test on 09.11.17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    var scnScene: SCNScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        
    }
    
    func setupView() {
        scnView = self.view as! SCNView
    }
    
    func setupScene() {
        scnScene = BirdScene(create: true)
        scnView.scene = scnScene

        // управление камерой

        //scnView.showsStatistics = true
        //scnView.allowsCameraControl = true
        //scnView.autoenablesDefaultLighting = true // свет на сцене

        scnView.delegate = (scnScene as! SCNSceneRendererDelegate)
        scnView.isPlaying = true
        
        scnView.backgroundColor = #colorLiteral(red: 0, green: 0.8000000119, blue: 1, alpha: 1)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}

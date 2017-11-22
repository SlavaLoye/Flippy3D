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
    var  gameScene: BirdScene?
    var menuScene: MenuScene?

   static var gameOverlay: GameSKOverlay?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        
    }
    
    func setupView() {
        scnView = self.view as! SCNView
    }
    
    func setupScene() {
        menuScene = MenuScene(create: true)
        GameViewController.gameOverlay = GameSKOverlay(sceneSize: self.view.frame.size)
        if let scene = menuScene, let overlay = GameViewController.gameOverlay {
            scnView.scene = scene
            scnView.isPlaying = true
            scnView.delegate = scene
            scnView.overlaySKScene = overlay
            scnView.backgroundColor = #colorLiteral(red: 0, green: 0.8000000119, blue: 1, alpha: 1)
        }
    }
    //MARK: - тапаем на птичку и она поднимается

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scene = gameScene {
            scene.emptyBird.physicsBody?.velocity = SCNVector3(0, 2, 0)
            scene.bird.runAction(scene.rotationSeq)
        }
        
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

//
//  GameSKOverlay.swift
//  FlappyBird3D
//
//  Created by Вячеслав Лойе on 23/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SpriteKit

class GameSKOverlay: SKScene {

    var playButtonNode = SKSpriteNode()
    var titleGame = SKSpriteNode()

    convenience init(sceneSize: CGSize) {
        self.init(size: sceneSize)

        let playTexture  = SKTexture(image: UIImage(named: "Title")!)
        playButtonNode = SKSpriteNode(texture: playTexture)
        playButtonNode.size = CGSize(width: 100, height: 100)
        playButtonNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButtonNode.position = CGPoint(x: self.size.width / 2, y: (self.size.height) - 200)
        //playButtonNode.name = "playButton"

        self.addChild(playButtonNode)

        let titelTexture = SKTexture(image: UIImage(named: "Replay")!)
	    titleGame = SKSpriteNode(texture: titelTexture)
        titleGame.size = CGSize(width: 300, height: 300)
        //titleGame.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        titleGame.position = CGPoint(x: self.size.width / 2, y: (self.size.height) + 180)

        self.addChild(titleGame)

    }
}

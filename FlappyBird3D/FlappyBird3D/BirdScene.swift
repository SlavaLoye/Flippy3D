//
//  BirdScene.swift
//  FlappyBird3D
//
//  Created by Test on 09.11.17.
//  Copyright © 2017 Test. All rights reserved.
// рендеринг на сцену
// модели освещения (constant, lambert, blinn, phong)

import SceneKit

class BirdScene: SCNScene {

    convenience init(create: Bool) {
        self.init()
        
        setupCameraAndLights()
        setupScenery()
    }

    // устанавливаем положение камеры
    
    func setupCameraAndLights() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.usesOrthographicProjection = false
        cameraNode.position = SCNVector3(0, 0, 0)
        // изиеняем камеру на сцену
        cameraNode.pivot = SCNMatrix4MakeTranslation(0, 0, -3)
        // добавляем камеру на сцену
        rootNode.addChildNode(cameraNode)
        // добавляем источник света
        let lightOne = SCNLight()
        lightOne.type = .spot
        // конусообразная освещенная область
        lightOne.spotInnerAngle = 90
        // расстояние от света в котором его интенсивность начинает уменьшаться
        lightOne.attenuationStartDistance = 0.0
        // кривая перехода для интенсивности света между ее затуханием
        lightOne.attenuationFalloffExponent = 2
         // расстояние от света в котором полностью уменьшена его  интенсивность
        lightOne.attenuationEndDistance = 30.0
	// распологаем несколько источников света на нашей сцене (на один Node можно привязать до 8 - ми источников света)
        let lighNodeSpot = SCNNode()
        lighNodeSpot.light = lightOne
        lighNodeSpot.position = SCNVector3(0, 10, 1)
        rootNode.addChildNode(lighNodeSpot)

        // добавляем источник света впереди сцены

        let lightNodeFront = SCNNode()
        lighNodeSpot.light = lightOne
        lighNodeSpot.position = SCNVector3(0, 1, 15)
        rootNode.addChildNode(lightNodeFront)

        // добавляем Node пустышку и добавляем на нее наши осточники света

        let emptyAtCenter = SCNNode()
        emptyAtCenter.position = SCNVector3Zero
        rootNode.addChildNode(emptyAtCenter)

        lighNodeSpot.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]
        lightNodeFront.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]
        cameraNode.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]

        //добавляем источник света для общей яркости нашей сцены

        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = .ambient
        ambientLight.light?.color = UIColor(white: 0.05, alpha: 1.0)
        // ставим все в корневой узел
        rootNode.addChildNode(ambientLight)

    }

    // создаем декорацию (земли)
    func setupScenery() {
        // создали геометрию земли
        let groundGeo = SCNBox(width: 4, height: 0.5, length: 0.4, chamferRadius: 0)
        groundGeo.firstMaterial!.diffuse.contents = #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1)
        //groundGeo.firstMaterial!.specular.contents = UIColor.black
        groundGeo.firstMaterial!.specular.contents = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        groundGeo.firstMaterial?.emission.contents = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
	// привязали ее к Node земли
        let groundNode = SCNNode(geometry: groundGeo)
        
        let emptySand = SCNNode()
        emptySand.addChildNode(groundNode)
        emptySand.position.y = -1.63

        rootNode.addChildNode(emptySand)
        
    }
    
}

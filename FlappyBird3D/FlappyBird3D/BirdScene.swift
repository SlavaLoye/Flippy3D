//
//  BirdScene.swift
//  FlappyBird3D
//
//  Created by Test on 09.11.17.
//  Copyright © 2017 Test. All rights reserved.
// рендеринг на сцену
// модели освещения (constant, lambert, blinn, phong)

import SceneKit

class BirdScene: SCNScene, SCNSceneRendererDelegate  {

    let emptyGrass1 = SCNNode()
    let emptyGrass2 = SCNNode()

    var runningUpdate = true
    var timeLast : Double?
    let speedConsnant = -0.7




    convenience init(create: Bool) {
        self.init()
        
        setupCameraAndLights()
        setupScenery()

        let propsScene = SCNScene(named: "art.scnassets/Props.dae")!
        emptyGrass1.scale = SCNVector3(easyScale: 0.15)
        emptyGrass1.position = SCNVector3(0, -1.3, 0)


        emptyGrass2.scale = SCNVector3(easyScale: 0.15)
        emptyGrass2.position = SCNVector3(4.45, -1.3, 0)

        let grass1 = propsScene.rootNode.childNode(withName: "Ground", recursively: true)!
        grass1.position = SCNVector3(-5.0, 0, 0)

        let grass2 = grass1.clone()
        grass1.position = SCNVector3(-5.0, 0, 0)

        emptyGrass1.addChildNode(grass1)
        emptyGrass2.addChildNode(grass2)

        rootNode.addChildNode(emptyGrass1)
        rootNode.addChildNode(emptyGrass2)
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

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let dt: Double

        if runningUpdate {
            if let lt = timeLast {
                dt = time - lt
            } else {
                dt = 0
            }
        } else {
            dt = 0
        }
    	timeLast = time

        moveGrass(node: emptyGrass1, dt: dt)
        moveGrass(node: emptyGrass2, dt: dt)

    }
    // func - для движения травы

    func moveGrass(node: SCNNode, dt: Double)  {
        // время умножаем на скорость
        node.position.x += Float(dt * speedConsnant)

        if node.position.x <= -4.45 {
            node.position.x = 4.45
        }

    }
    
}

// расширяем SCNVector3 для переменной emptyGrass

extension SCNVector3 {
    init(easyScale: Float) {
        self.x = easyScale
        self.y = easyScale
        self.z = easyScale

    }
}

//
//  GameScene.swift
//  Helicopter
//
//  Created by Thomas Markussen on 23/01/2018.
//  Copyright © 2018 ThomasM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        createHeli()
    }
    
    func createHeli(){
        let heli = SKSpriteNode(imageNamed: "heli1.png")
        heli.position = CGPoint(x: 100, y: 100)
        self.addChild(heli)
        
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

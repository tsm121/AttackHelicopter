//
//  GameScene.swift
//  Helicopter
//
//  Created by Thomas Markussen on 23/01/2018.
//  Copyright © 2018 ThomasM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var heli: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createHeli()
        createArea()
        moveHeli()
    }
    
    func createHeli(){
        heli = SKSpriteNode(imageNamed: "heli1.png")
        heli.position = CGPoint(x: 100, y: 100)
        heli.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heli.size.width, height: heli.size.height))
        heli.physicsBody?.affectedByGravity = false
        heli.physicsBody?.angularDamping = CGFloat(0.0)
        heli.physicsBody?.linearDamping = CGFloat(0.0)
        heli.physicsBody?.restitution = CGFloat(1)
        self.addChild(heli)
    }

    func createArea() {
        self.backgroundColor = .purple
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
    }
    
    func moveHeli(){
        heli.physicsBody?.velocity = CGVector(dx: 200.0, dy: 200.0)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

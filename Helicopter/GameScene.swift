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
        moveHeliRandom()
    }
    
    func createHeli(){
        heli = SKSpriteNode(imageNamed: "heli1.png")
        heli.position = CGPoint(x: 225, y: 35)
        heli.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heli.size.width, height: heli.size.height))
        heli.physicsBody?.affectedByGravity = false
        heli.physicsBody?.angularDamping = CGFloat(0.0)
        heli.physicsBody?.linearDamping = CGFloat(0.0)
        heli.physicsBody?.restitution = CGFloat(1)
        self.addChild(heli)
    }

    func createArea() {
        self.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = UIColor(red:255, green:0, blue: 254, alpha: 1.0)
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
    }
    
    func moveHeliRandom(){
        heli.physicsBody?.velocity = CGVector(dx: 200.0, dy: 200.0)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

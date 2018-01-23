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
    private var touchLocation: CGPoint?
    private var heliAtlas = [SKTexture]()


    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        
        createHeli()
        createArea()
        createAtlas()
        animateHeli()
        moveHeliRandom()
    }
    
    //Add helicopter in gamescene and set physics
    func createHeli(){
        heli = SKSpriteNode(imageNamed: "heli1.png")
        heli.position = CGPoint(x: 225, y: 35)
        heli.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heli.size.width, height: heli.size.height))
        heli.physicsBody?.affectedByGravity = false
        heli.physicsBody?.angularDamping = CGFloat(0)
        heli.physicsBody?.linearDamping = CGFloat(0)
        heli.physicsBody?.restitution = CGFloat(1)
        heli.physicsBody?.allowsRotation = false
        self.addChild(heli)
    }

    //Create player area with bounderies, together with physics
    func createArea() {
        self.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = UIColor(red:255, green:0, blue: 254, alpha: 1.0)
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
    }
    
    //Creates an atlas from helicopter textures
    func createAtlas(){
        let atlas = SKTextureAtlas(named: "heli")
        let f1 = atlas.textureNamed("heli1.png")
        let f2 = atlas.textureNamed("heli2.png")
        let f3 = atlas.textureNamed("heli3.png")
        let f4 = atlas.textureNamed("heli4.png")
        
        heliAtlas.append(f1)
        heliAtlas.append(f2)
        heliAtlas.append(f3)
        heliAtlas.append(f4)
        
    }
    
    //Animate helicopter per frame
    func animateHeli(){
        heli.run(SKAction.repeatForever(
            SKAction.animate(with: heliAtlas,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)))
    }
    
    //Moves the helicopter with a given velocity
    func moveHeliRandom(){
        heli.physicsBody?.velocity = CGVector(dx: 200.0, dy: 200.0)

    }
    
    //Touch controls for helicopter
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.location(in: self)
            heli?.position.x = (touchLocation?.x)!
            heli?.position.y = (touchLocation?.y)!
            
            //let position = touch.location(in: view)
            //print(position)

        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
}

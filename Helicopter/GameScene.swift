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
    private var heli1: SKSpriteNode!
    private var heli2: SKSpriteNode!
    private var touchLocation: CGPoint?
    private var heliAtlas = [SKTexture]()


    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
    
        createArea()
        addHeli()
        createAtlas()
        
        animateHeli(heliSprite: heli1)
        animateHeli(heliSprite: heli2)
        moveHeliRandom(sprite: heli1)
        moveHeliRandom(sprite: heli2)

    }
    
    func addHeli(){
        heli1 = Helicopter()
        heli2 = Helicopter()
        var xPos:Int = self.getRandomNum(lowerValue: 0, upperValue: 300)
        var yPos:Int = self.getRandomNum(lowerValue: 0, upperValue: 300)
        heli1.position = CGPoint(x:xPos,y:yPos)
        
        xPos = self.getRandomNum(lowerValue: 0, upperValue: 300)
        yPos = self.getRandomNum(lowerValue: 0, upperValue: 300)
        heli2.position = CGPoint(x:xPos,y:yPos)
        
        heli1.name = "heli1"
        heli2.name = "heli2"
        
        self.addChild(heli1)
        self.addChild(heli2)
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
    func animateHeli(heliSprite: SKSpriteNode){
        heliSprite.run(SKAction.repeatForever(
            SKAction.animate(with: heliAtlas,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)))
    }
    
    //Moves the helicopter with a given velocity
    func moveHeliRandom(sprite: SKSpriteNode){
        
        //Get two random directions
        let dx = self.getRandomNum(lowerValue: -200, upperValue: 400)
        let dy = self.getRandomNum(lowerValue: -200, upperValue: 400)

        //Apply velocity
        sprite.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
    }
    
    //Create random number
    func getRandomNum(lowerValue:Int, upperValue:Int) -> Int{
        return Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
    }
    
    //Touch controls for helicopter and freeze when touched
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches{
            var touchLocation = touch.location(in: self)
            let targetNode = atPoint(touchLocation) as? SKSpriteNode
            
            if targetNode == nil{
                return
            } else{
                targetNode?.physicsBody?.velocity = CGVector(dx: 0, dy:0)
                touchLocation = touch.location(in: self)
                targetNode?.position.x = (touchLocation.x)
                targetNode?.position.y = (touchLocation.y)
            }
            //let position = touch.location(in: view)
            //print(position)

        }
    }
    
    //Move helicopter after touching it
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as? SKSpriteNode
        
        if targetNode != nil{
            moveHeliRandom(sprite:targetNode!)
        }
    }


    override func update(_ currentTime: TimeInterval) {
    }
    
    
    //Class for helicopter
    class Helicopter: SKSpriteNode {
        init() {
            let texture = SKTexture(imageNamed: "heli1.png")
            super.init(texture: texture, color: .blue, size: texture.size())
            
            //Set position and physics
            self.position = CGPoint(x: 225, y: 35)
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.angularDamping = CGFloat(0)
            self.physicsBody?.linearDamping = CGFloat(0)
            self.physicsBody?.restitution = CGFloat(1)
            self.physicsBody?.allowsRotation = false
            //self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            
        }
    }
}


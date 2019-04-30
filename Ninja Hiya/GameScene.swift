//
//  GameScene.swift
//  Ninja Hiya
//
//  Created by LUKE REUPERT on 4/8/19.
//  Copyright © 2019 LUKE REUPERT. All rights reserved.
//

import SpriteKit
import GameplayKit
struct physicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let enemy: UInt32 = 2//number 1
    static let projectile: UInt32 = 4//number 2
    static let player: UInt32 = 1
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    
  var player = SKSpriteNode(imageNamed: "ninja")
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let backgroundMusic = SKAudioNode(fileNamed: "gameMusic.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        backgroundColor = UIColor.white
      physicsWorld.gravity = CGVector.zero
        
        createPlayer()
       createEnemy()
        //for i in 0...9{
            //createEnemy()
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createEnemy),SKAction.wait(forDuration: 1.0)])))
     //   }
     //       print("hi")
}
    
    func randomPoint()-> CGPoint{
        var xPos = Int.random(in: 0...Int(self.size.width))
        var yPos = Int.random(in: 0...Int(self.size.height))
        return CGPoint(x: xPos, y: yPos)
    }
    
    
    
    func createPlayer() {
        player.position = CGPoint(x: 50, y: 200)
      //  player.position = randomPoint()
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody?.pinned = true
        player.scale(to: CGSize(width: 80, height: 80))
        player.physicsBody?.affectedByGravity = false
player.physicsBody?.mass = 1
        player.physicsBody?.allowsRotation = false
      player.physicsBody?.categoryBitMask = physicsCategory.player
        player.physicsBody?.contactTestBitMask = physicsCategory.enemy
        addChild(player)
               // player.physicsBody?.applyImpulse(CGVector(dx: 2000, dy: 0))
        
    }
    func createEnemy (){
        var enemy = SKSpriteNode(imageNamed: "mean ninja")
       // enemy.position = randomPoint()
       enemy.position = CGPoint(x: self.size.width, y: 300)
        addChild(enemy)
        enemy.scale(to: CGSize(width: 50, height: 50))
   enemy.physicsBody?.mass = 1
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        let actionMove = SKAction.move(to: CGPoint(x: 0, y: 300), duration: TimeInterval (CGFloat.random(in: 2.0...4.0)))
    let actionMoveDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([actionMove,actionMoveDone]))
   enemy.physicsBody?.allowsRotation = false
   enemy.physicsBody?.categoryBitMask = physicsCategory.enemy
    enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.contactTestBitMask = physicsCategory.projectile
        //enemy.physicsBody?.collisionBitMask = physicsCategory.none
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        
        let projectile = SKSpriteNode(imageNamed: "star")
        projectile.position = player.position
   projectile.physicsBody = SKPhysicsBody(rectangleOf: projectile.size)
       projectile.physicsBody?.mass = 1
         addChild(projectile)
        let offset = touchLocation - projectile.position
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
        //projectile.physicsBody?.categoryBitMask = physicsCategory.project
projectile.physicsBody?.allowsRotation = false
   projectile.physicsBody?.categoryBitMask = physicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = physicsCategory.enemy
       // projectile.physicsBody?.collisionBitMask = physicsCategory.none
        let actionMove = SKAction.move(to: realDest, duration: TimeInterval(2.0))
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove,actionMoveDone]))
    
    }
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
      let one = contact.bodyA.node as? SKSpriteNode
   let two = contact.bodyB.node as? SKSpriteNode
        one?.removeFromParent()
        two?.removeFromParent()
    }
}

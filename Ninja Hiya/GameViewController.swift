//
//  GameViewController.swift
//  Ninja Hiya
//
//  Created by LUKE REUPERT on 4/8/19.
//  Copyright © 2019 LUKE REUPERT. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        let skView = self.view as! SKView
            // Load the SKScene from 'GameScene.sks'
        
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                skView.presentScene(scene)
            
            
           skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        }

       override var prefersStatusBarHidden: Bool {
        return true
    }

}


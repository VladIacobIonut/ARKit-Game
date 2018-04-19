//
//  SpaceShip.swift
//  ARKitGame
//
//  Created by Vlad on 06/02/2018.
//  Copyright © 2018 Vlad Iacob. All rights reserved.
//

import UIKit
import ARKit

class SpaceShip: SCNNode {
    
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/ship.scn") else {
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
             wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
    }
}

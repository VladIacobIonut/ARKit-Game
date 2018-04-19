//
//  ViewController.swift
//  ARKitGame
//
//  Created by Vlad on 06/02/2018.
//  Copyright © 2018 Vlad Iacob. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var timerLbl: UILabel!
    
    var timer = Timer()
    
    var counter:Int = 0 {
        didSet {
            counterLbl.text = "Score: \(counter)"
        }
    }
    
    var timerCounter:Int = 10 {
        didSet {
            timerLbl.text = "Time left: \(timerCounter)s"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        
        addObject()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    func addObject() {
        let ship = SpaceShip()
        ship.loadModel()
        
        let xPos =  randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPos, yPos, -1)
        
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    func randomPosition(lowerBound lower: Float, upperBound upper:Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "ARShip" {
                    counter += 1 
                    node.removeFromParentNode()
                    addObject()
                    
                }
            }
            
            
        }
    }
    
    @objc func timerTicked() {
        timerCounter -= 1
        if (timerCounter == 0) {
            timerCounter = 10
            timer.invalidate()
            let alert = UIAlertController(title: "Congrats 🤙", message: "You found \(counter) ships", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            counter = 0
        }
    }
    
    @IBAction func startGameBtnPressed(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerTicked), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


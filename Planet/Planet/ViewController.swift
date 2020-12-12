//
//  ViewController.swift
//  The-Planet
//
//  Created by  ParkSeongWon on 2020/12/11.
//

import UIKit
import SceneKit
import ARKit
import RealityKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene()
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
            print("No images available")
            return
        }
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 3
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) ->
    SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            // Sun
            if (imageAnchor.referenceImage.name == "sunmarker") {
                // Create the plan that cover the marker
                let sunplane = SCNPlane(width:
                    imageAnchor.referenceImage.physicalSize.width, height:
                    imageAnchor.referenceImage.physicalSize.height)
                // Plane is white and has alpha value 0.8
                sunplane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
                let sunplaneNode = SCNNode(geometry: sunplane)
                // Set the plane angle
                sunplaneNode.eulerAngles.x = -.pi / 2
                // Create the sphere
                let sun = SCNSphere(radius: 0.09)
                // Texture of the sphere, in this case, sun surface
                sun.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/sun.jpg")
                let sunNode = SCNNode(geometry: sun)
                // Set the sun position
                sunNode.position = SCNVector3(0.0,0.0,0.0)
                sunNode.position.z = 0.15
                sunplaneNode.addChildNode(sunNode)
                // Animation effect of sun (rotation)
                addAnimation(node: sunNode)
                node.addChildNode(sunplaneNode)
            }
            
            // Earth
            if (imageAnchor.referenceImage.name == "earthmarker") {
                // Create the plan that cover the marker
                let earthplane = SCNPlane(width:
                    imageAnchor.referenceImage.physicalSize.width, height:
                    imageAnchor.referenceImage.physicalSize.height)
                // Plane is white and has alpha value 0.8
                earthplane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
                let earthplaneNode = SCNNode(geometry: earthplane)
                // Set the plane angle
                earthplaneNode.eulerAngles.x = -.pi / 2
                // Create the sphere
                let earth = SCNSphere(radius: 0.055)
                // Texture of the sphere, in this case, earth surface
                earth.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/earth.jpg")
                let earthNode = SCNNode(geometry: earth)
                // Set the earth position
                earthNode.position = SCNVector3(0.0,0.0,0.0)
                earthNode.position.z = 0.15
                earthplaneNode.addChildNode(earthNode)
                // Animation effect of earth (rotation)
                addAnimation(node: earthNode)
                node.addChildNode(earthplaneNode)
            }

            // Moon
            if (imageAnchor.referenceImage.name == "moonmarker") {
                // Create the plan that cover the marker
                let moonplane = SCNPlane(width:
                    imageAnchor.referenceImage.physicalSize.width, height:
                    imageAnchor.referenceImage.physicalSize.height)
                // Plane is white and has alpha value 0.8
                moonplane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
                let moonplaneNode = SCNNode(geometry: moonplane)
                // Set the plane angle
                moonplaneNode.eulerAngles.x = -.pi / 2
                // Create the sphere
                let moon = SCNSphere(radius: 0.035)
                // Texture of the sphere, in this case, moon surface
                moon.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
                let moonNode = SCNNode(geometry: moon)
                // Set the moon position
                moonNode.position = SCNVector3(0.0,0.0,0.0)
                moonNode.position.z = 0.15
                moonplaneNode.addChildNode(moonNode)
                // Animation effect of moon (rotation)
                addAnimation(node: moonNode)
                node.addChildNode(moonplaneNode)
            }
        }
        return node
    }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: CGFloat(Float.pi), duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
}

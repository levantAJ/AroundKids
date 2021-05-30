//
//  ViewController.swift
//  AroundKids
//
//  Created by Tai Le on 23/05/2021.
//

import UIKit
import ARKit
import SceneKit
import TheConstraints

class ViewController: UIViewController {
    lazy var sceneView: ARSCNView = makeScenceView()
    lazy var usdzNodes: [USDZNode] = []
    lazy var soundPlayer: SoundPlayer = SoundPlayer()
    lazy var animalTypes: [USDZNodeARObjectType] = USDZNodeARObjectType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if  let touch: UITouch = touches.first,
            touch.view == sceneView {
            print("touch working")
            let viewTouchLocation: CGPoint = touch.location(in: sceneView)

            guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                return
            }
            for node in usdzNodes {
                if result.node.hasAncestor(node) {
                    if let soundName: String = ((result.node as? USDZNode)?.arObjectType.soundName) ?? node.arObjectType.soundName {
                        soundPlayer.play(name: soundName)
                    }
                }
            }
        }
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor: ARPlaneAnchor = anchor as? ARPlaneAnchor else { return }

        // 2
//        let width = CGFloat(planeAnchor.extent.x)
//        let height = CGFloat(planeAnchor.extent.z)
//        let plane = SCNPlane(width: width, height: height)

        // 3
//        plane.materials.first?.diffuse.contents = UIColor.systemBlue

        // 4
//        let planeNode = SCNNode(geometry: plane)

        // 5
        let x: CGFloat = CGFloat(planeAnchor.center.x)
        let y: CGFloat = CGFloat(planeAnchor.center.y)
        let z: CGFloat = CGFloat(planeAnchor.center.z)
        let position: SCNVector3 = SCNVector3(x, y, z)
//        planeNode.position = SCNVector3(x,y,z)
//        planeNode.eulerAngles.x = -.pi / 2

        // 6
//        node.addChildNode(planeNode)

        // 7 Add USDZ node
        let arObjectType: USDZNodeARObjectType = animalTypes.randomElement() ?? .chicken
        if let usdzNode: USDZNode = USDZNode(
            arObjectType: arObjectType,
            position: position
        ) {
            node.addChildNode(usdzNode)
            usdzNodes.append(usdzNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor: ARPlaneAnchor = anchor as? ARPlaneAnchor else { return }

//        let planeNode = node.childNodes.first,
//            let plane = planeNode.geometry as? SCNPlane

        // 2
//        let width = CGFloat(planeAnchor.extent.x)
//        let height = CGFloat(planeAnchor.extent.z)
//        plane.width = width
//        plane.height = height

        // 3
        let x: CGFloat = CGFloat(planeAnchor.center.x)
        let y: CGFloat = CGFloat(planeAnchor.center.y)
        let z: CGFloat = CGFloat(planeAnchor.center.z)
        let position: SCNVector3 = SCNVector3(x, y, z)
//        planeNode.position = SCNVector3(x, y, z)

        // 4 Update the current USDZ node
        if let usdZNode: USDZNode = node.childNodes.first(
            where: { $0 is USDZNode }
        ) as? USDZNode {
            usdZNode.position = position
        }
    }
}

// MARK: - Privates

extension ViewController {
    private func setupViews() {
        view.addSubview(sceneView)
        sceneView.edges == view.edges
    }

    private func makeScenceView() -> ARSCNView {
        let view: ARSCNView = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        return view
    }
}

extension SCNNode {
    func hasAncestor(_ node: SCNNode) -> Bool {
        if self === node {
            return true // this is the node you're looking for
        }

        if node.contains(self) || contains(node) {
            return true
        }

        if parent === node {
            return true
        }

        if let parent: SCNNode = parent {
            return parent.hasAncestor(node)
        }

        return false
    }
}

//
//  USDZNode.swift
//  AroundKids
//
//  Created by Tai Le on 23/05/2021.
//

import UIKit
import SceneKit

class USDZNode: SCNReferenceNode {
    let arObjectType: USDZNodeARObjectType

    init?(
        arObjectType: USDZNodeARObjectType,
        position: SCNVector3? = nil,
        pivot: SCNMatrix4? = nil
    ) {
        let name: String = arObjectType.name
        guard let usdzURL: URL = Bundle.main.url(forResource: name, withExtension: "usdz") else { return nil }
        self.arObjectType = arObjectType
        super.init(url: usdzURL)
        self.scale = arObjectType.scale
        if let position: SCNVector3 = position {
            self.position = position
        }
        if let pivot: SCNMatrix4 = pivot {
            self.pivot = pivot
        }
        self.load()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SCNMatrix4

extension SCNMatrix4 {
    static func random() -> SCNMatrix4 {
        return SCNMatrix4MakeRotation(Float.random(in: 0...2*Float.pi), 0, 1, 0)
    }
}

// MARK: - USDZNodeARObjectType

enum USDZNodeARObjectType: Equatable, CaseIterable {
    case chicken
    case shark
    case fish
    case cat

    var name: String {
        switch self {
        case .chicken:
            return "chicken"
        case .shark:
            return "shark"
        case .cat:
            return "cat"
        case .fish:
            return "fish"
        }
    }

    var scale: SCNVector3 {
        switch self {
        case .fish:
            return SCNVector3(x: 0.3, y: 0.3, z: 0.3)
        case .chicken:
            return SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        case .cat:
            return SCNVector3(x: 0.003, y: 0.003, z: 0.003)
        case .shark:
            return SCNVector3(x: 0.002, y: 0.002, z: 0.002)
        }
    }

    var soundName: String? {
        switch self {
        case .chicken:
            return "rooster-crowing"
        case .shark, .cat, .fish:
            return nil
        }
    }
}

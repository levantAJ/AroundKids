//
//  Collection.swift
//  SafetyCollection
//
//  Created by Tai Le on 11/17/19.
//  Copyright © 2019 Tai Le. All rights reserved.
//

public extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

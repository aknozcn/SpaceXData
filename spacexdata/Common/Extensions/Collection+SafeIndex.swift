//
//  Collection+SafeIndex.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

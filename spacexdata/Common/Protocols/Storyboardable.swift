//
//  Storyboardable.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
    case detailScreen = "DetailScreen"
}

protocol Storyboardable {
    static var storyboardIdentifier: String { get }
    static func instantiate(storyboardName: StoryboardName) -> Self
}

extension Storyboardable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate(storyboardName: StoryboardName) -> Self {
        guard let viewController = UIStoryboard(name: storyboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("storyboard identifier : \(storyboardIdentifier)")
        }
        return viewController
    }
}

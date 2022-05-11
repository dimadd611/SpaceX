//
//  UIView+Extensions.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import Foundation
import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
}

//
//  Utilities.swift
//  Phone Book
//
//  Created by Pavlo Novak on 3/7/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    static func generateImageWithText(text: String, color: UIColor) -> UIImage{
        
        let image = UIImage()
        var newText = ""
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = color
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        for i in text {
            if newText.count == 2 {
                break
            }
            if i >= "A" && i <= "Z" || i >= "А" && i <= "Я" {
                newText.append(i)
            }
        }
        label.text = newText
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithText!
    }
}

extension CGColor {
    
    static func chooseColor() -> UIColor {
        
        var color = [0.0, 0.0, 0.0]
        for i in 0..<color.count {
            color[i] = Double(arc4random_uniform(UInt32(254)))
        }
        return UIColor(red: CGFloat(color[0]/255), green: CGFloat(color[1]/255), blue: CGFloat(color[2]/255), alpha: 0.2)
    }
}






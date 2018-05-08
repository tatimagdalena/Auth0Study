//
//  UIColor.swift
//  StonePortal
//
//  Created by Tatiana Magdalena on 11/24/16.
//  Copyright © 2016 Stone Pagamentos. All rights reserved.
//

import UIKit

struct Color {
    static let brandbookPalette = BrandbookPalette()
}

extension Color {
    struct BrandbookPalette {
        let darkGreen = UIColor(hexString: "#103A21")
        let midDarkGreen = UIColor(hexString: "#14AA4B")
        let midLightGreen = UIColor(hexString: "#95C93F")
        let lightGreen = UIColor(hexString: "#D6EACE")
        let midDarkGray = UIColor(hexString: "#A8A9AD")
        let darkGray = UIColor(hexString: "#5C666A")
        let white = UIColor.white
    }
}

extension UIColor {
    
    /**
     Creates an UIColor from HEX Value in 0x363636 format
     
     - parameter hexString: HEX String in 0x363636 format
     - returns: UIColor from HexString
     */
    convenience init(hex: Int) {
        let red =   CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(hex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /**
     Creates an UIColor Object based on provided RGB value in integer
     - parameter red:   Red Value in integer (0-255)
     - parameter green: Green Value in integer (0-255)
     - parameter blue:  Blue Value in integer (0-255)
     - returns: UIColor with specified RGB values
     */
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
}

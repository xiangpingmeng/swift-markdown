//
//  String+Extension.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/3/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

extension String {
    
    func leadingSpaces() -> Int {
        
        var leadingNumber = 0
        
        for char:Character in self {
           
            if char == " " {
                leadingNumber += 1
            }else{
                return leadingNumber
            }
            
        }
        
        return 0
    }
    
}
//
//  ATXHeader.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/24/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

class ATXHeader : MarkdownNode,MarkdownNodeProtocol {
    
    var level:Int = 1
    
    init(content: String, level:Int) {
        
        super.init(content: content)
        self.level = level
        
    }
    
    override func toHTML() -> String {
        
        if level > 0 && level < 7 {
            
            return "<h\(level)>\(self.content!)</h\(level)>"
            
        }else{
            
            return ""
            
        }
        
    }
    
}
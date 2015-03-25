//
//  SetextHeader.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/25/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

enum SetextType {
    
    case H1
    case H2
    
}

class SetextHeader: MarkdownNode, MarkdownNodeProtocol {
    
    var type:SetextType = SetextType.H1
    
    init(content: String, type:SetextType) {
        
        super.init(content: content)
        self.type = type
        
    }
    
    override func toHTML() -> String {
        
        if self.type == SetextType.H1 {
            
            return "<h1>\(self.content!)</h1>"
            
        }else if self.type == SetextType.H2 {

            return "<h2>\(self.content!)</h2>"
            
        }else{
            
            return ""
            
        }
        
    }
    
}
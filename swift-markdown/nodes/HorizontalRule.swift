//
//  HorizontalRule.swift
//  
//
//  Created by mengxiangping on 3/1/15.
//
//

import Foundation

class HorizontalRule : MarkdownNode, MarkdownNodeProtocol {
    
    override func toHTML() -> String {
        
        return "<hr />"
        
    }
    
    
}
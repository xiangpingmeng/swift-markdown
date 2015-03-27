//
//  IndentedCodeBlock.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/25/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

class IndentedCodeBlock : MarkdownNode, MarkdownNodeProtocol {
    
    override func toHTML() -> String {
        
        var lines = self.content!.componentsSeparatedByString("\n");

        
        var notEmptyFounded = false

        
        var startIndex = lines.count - 1
        
        while startIndex >= 0 {
            
            if lines[lines.count - 1].trimFromEnd(" ").trimFromStart(" ").isEmpty {
                
                lines.removeAtIndex(lines.count - 1)
                
            }else{
                
                break
                
            }
            
            startIndex--
            
        }
        
        var result:String = ""
        
        for line in lines {
            
            result += line + "\n"
            
        }
        
        return "<pre><code>\(result)</code></pre>"
        
    }
    
}
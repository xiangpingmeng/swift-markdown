//
//  FencedCodeBlock.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/26/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

class FencedCodeBlock : MarkdownNode, MarkdownNodeProtocol {
    
    var infoString:String?
    
    override func toHTML() -> String {
        
        self.encodeHTMLEntities()
        
        if infoString != nil {

            return "<pre><code class=\"language-\(infoString)\">\(self.content!)</code></pre>"
            
        }else{

            return "<pre><code>\(self.content!)</code></pre>"
            
        }

        
    }
    
}
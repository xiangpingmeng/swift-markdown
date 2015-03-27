//
//  FencedCodeBlock.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/26/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

class FencedCodeBlock : MarkdownNode, MarkdownNodeProtocol {
    
    override func toHTML() -> String {
        
        self.encodeHTMLEntities()
        return "<pre><code>\(self.content!)</code></pre>"
        
    }
    
}
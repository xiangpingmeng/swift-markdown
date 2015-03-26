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
        
        return "<pre><code>\(self.content!)</code></pre>"
        
    }
    
}
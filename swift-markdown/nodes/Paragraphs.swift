//
//  Paragraphs.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/3/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

class Paragraphs : MarkdownNode,MarkdownNodeProtocol {
    
    override func toHTML() -> String {
        
        return "<p>\(self.content!)</p>"
        
    }
    
}
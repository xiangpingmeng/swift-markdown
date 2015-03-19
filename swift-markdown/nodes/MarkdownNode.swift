//
//  MarkdownNode.swift
//  
//
//  Created by mengxiangping on 3/1/15.
//
//

import Foundation


protocol MarkdownNodeProtocol {
    
    func toHTML() -> String;
    
}

class MarkdownNode : MarkdownNodeProtocol{
    
    var parent:MarkdownNode?
    var childs:Array<MarkdownNode>?
    var content:String?
    
    init(content:String) {
        
        self.childs = [];
        self.content = content;
        
    }
    
    
    func append(node:MarkdownNode) {
        
        self.childs?.append(node);
        
    }
    
    func toHTML() -> String{
        
        return self.content!
    }
    
    
}
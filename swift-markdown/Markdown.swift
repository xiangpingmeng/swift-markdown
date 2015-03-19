//
//  Markdown.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/1/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation


class Markdown {
    
    var document:String?
    
    var root:MarkdownNode?
    
    init(document:String) {
        
        self.document = document
        
    }
    
    func parseHr(content:String) -> Bool {
        
        if content == "***" || content == "---" || content == "___" {
            return true
        }
        
        //check white space
        
        
        return false
        
    }
    
    func parseAST() -> MarkdownNode {
        
        self.root = MarkdownNode(content: "")
        
        if let doc = self.document {
            
            var lines:Array<String> = doc.componentsSeparatedByString("\n")
            
            for line:String in lines {
                
                
                if line == "---" || line == "***" || line == "___" {
                    
                    var hr:HorizontalRule = HorizontalRule(content: line)
                    self.root!.append(hr)

                }else{
                    
                    var p:Paragraphs = Paragraphs(content: line)
                    self.root!.append(p)
                    
                }
                
            }
            
        }
        
        return root!
        
    }
    
    func htmlString() -> String {
        
        if(self.root == nil){
            self.parseAST()
        }
        
        return self.toHTML(self.root!)
        
    }
    
    func toHTML(node:MarkdownNode) -> String {
        
        if node.childs != nil && node.childs!.count > 0 {
            
            var contents:String = ""
            
            for item in enumerate(node.childs!) {

                contents += "\(toHTML(item.element))"
                if item.index < node.childs!.count - 1 {
                    
                    contents += "\n"
                    
                }
            }
            
            return contents
            
        }else {
  
            return node.toHTML()
            
        }
        
    }
    
}
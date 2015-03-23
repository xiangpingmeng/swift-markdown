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
            
            var lineCache:String = ""
            
            for line:String in lines {
                
                
                var curLine = line;
                
                if(curLine.leadingSpaces() < 4){

                    curLine = curLine.trimFromStart(" ");
                    
                }
                
                if(lineCache.utf16Count > 0){
                    lineCache += "\n";
                }
                
                //try to parse <hr />
                var filtedLine = curLine.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
                
                let hrChar1:Character = "-"
                let hrChar2:Character = "*"
                let hrChar3:Character = "_"
                
                if (filtedLine.countOfChar(hrChar1) >= 3 && filtedLine.countOfChar(hrChar1) == countElements(filtedLine)) ||
                    (filtedLine.countOfChar(hrChar2) >= 3 && filtedLine.countOfChar(hrChar2) == countElements(filtedLine)) ||
                    (filtedLine.countOfChar(hrChar3) >= 3 && filtedLine.countOfChar(hrChar3) == countElements(filtedLine)) {
                    
                    var hr:HorizontalRule = HorizontalRule(content: curLine)
                    self.root!.append(hr)

                }else{
                    
                    lineCache += curLine;
                    
                }
                
            }
            
            if(lineCache.utf16Count > 0){
                
                var p:Paragraphs = Paragraphs(content: lineCache)
                self.root!.append(p)
                
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
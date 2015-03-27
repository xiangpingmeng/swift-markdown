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
    
    var lineCache: String?
    
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
            
            lineCache = ""
            var blockStart = false

            var fencedBlockStart = false
            var fencedIdentifier = ""

            for line:String in lines {
                
                var curLine = line
                
                if(curLine == ""){
                    
                    if blockStart == false && fencedBlockStart == false {
                        
                        buildAndCleanCache()
                        
                    }else{
                        
                        lineCache? += "\n"
                        
                    }
                    
                    continue
                    
                }else{

                    if(curLine.leadingSpaces() < 4){

                        //check fenced code block
                        var lineTrimmed = curLine.trimFromStart(" ").trimFromEnd(" ")
                        
                        if lineTrimmed == "~~~" || lineTrimmed == "```" {
                            	
                            if fencedBlockStart == false {
                                
                                fencedIdentifier = lineTrimmed
                                fencedBlockStart = true
                                continue
                                
                            }else {
                                
                                fencedBlockStart = false
                                var fencedCodeBlock = FencedCodeBlock(content:lineCache!)
                                self.root?.append(fencedCodeBlock)
                                lineCache = ""
                                continue
                            }
                            
                        }
                        
                        if fencedBlockStart {
                            
                            lineCache? += curLine + "\n"
                            continue
                            
                        }
                        
                        
                        if curLine.countOfChar(" ") == countElements(curLine) {
                            lineCache? += "\n"
                            continue
                            
                        }else{
                        
                            if blockStart == true {
                                
                                var indentedCodeBlock:IndentedCodeBlock = IndentedCodeBlock(content:lineCache!)
                                self.root?.append(indentedCodeBlock)
                                lineCache = ""
                                
                            }
                            
                            blockStart = false
                            curLine = curLine.trimFromStart(" ");

                        }
                        
                        
                    }else{
                        
                        //code block will ignore white space line
                        if curLine.countOfChar(" ") == countElements(curLine) &&
                            blockStart == false
                        {
                            
                            continue;
                            
                        }
                        
                        if countElements(lineCache!) == 0 /** in paragraph **/
                            || blockStart {
                            
                            blockStart = true
                            lineCache? += curLine.substringFromIndex(advance(curLine.startIndex, 4)) + "\n"
                            continue
                            
                        }
                        
                    }
                    
                    if let header = self.parseATXHeader(curLine) {
                     
                        //try to parse <h?>content</h?>
                        buildAndCleanCache()
                        self.root?.append(header)
                     
                        
                    }else if let setextHeader = self.parseSetextHeader(curLine, lineCache: lineCache!) {
                        
                        //try to parse <h?>content<h?>
                        lineCache = ""
                        self.root?.append(setextHeader)
                        
                    } else if let hr = self.parseHr(curLine) {
                        //try to parse <hr />
                        buildAndCleanCache()
                        self.root?.append(hr)
                    }
                    else {
                        
                        if(lineCache?.utf16Count > 0){
                            lineCache? += "\n";
                        }
                        
                        lineCache? += curLine.trimFromStart(" ");
                        
                    }

                    
                }
                
                
            }
            
            
            if blockStart {
                
                var indentedCodeBlock:IndentedCodeBlock = IndentedCodeBlock(content:lineCache!)
                self.root?.append(indentedCodeBlock)
                lineCache = ""
                
            }else {

                buildAndCleanCache()
                
            }
            

            
        }
        
        return root!
        
    }
    
    
    private func buildAndCleanCache() {
        
        if(self.lineCache?.utf16Count > 0){
            
            var p:Paragraphs = Paragraphs(content: self.lineCache!)
            self.root!.append(p)
            lineCache = ""
            
        }
        
    }
//    
    private func parseSetextHeader(curLine: String, lineCache:String) -> SetextHeader? {
        
        if(curLine.leadingSpaces() >= 4){
            return nil
        }
        
        if lineCache.isEmpty == false && lineCache.numberOfLines() == 1 {
            
            var countOfEqual = curLine.countOfChar("=")
            if countOfEqual == countElements(curLine.trimFromStart(" ").trimFromEnd(" ")) {
                
                var setextHeader = SetextHeader(content: lineCache.trimFromEnd(" "), type: SetextType.H1)
                return setextHeader
                
            }
            
            var countOfMinus = curLine.countOfChar("-")
            if countOfMinus > 1 && countOfMinus == countElements(curLine.trimFromStart(" ").trimFromEnd(" ")) {
                
                var setextHeader = SetextHeader(content: lineCache.trimFromEnd(" "), type: SetextType.H2)
                return setextHeader
                
            }
            
        }
        
        return nil
    }
    
    private func parseATXHeader(curLine: String) -> ATXHeader? {
        
        var keyChar:Character = "#"
        
        var level = curLine.numberOfLeadingChar(keyChar);
        if level > 0 && level < 7 {
            
            //empty header
            var line = curLine.trimFromStart("#")
            
            //protential risk
            var testForEmpty = line.trimFromStart(" ")
            testForEmpty = testForEmpty.trimFromEnd(" ")
            testForEmpty = testForEmpty.trimFromEnd("#")
            
            if testForEmpty.isEmpty {
                
                var headerNode:ATXHeader = ATXHeader(content: "", level: level)
                return headerNode;
                
            }
            
            if line.hasPrefix(" ") {
                
                //remove leading # chars
                var headerString = line.trimFromStart(" ")
                headerString = headerString.trimFromEnd(" ")
                
                var headerLength = countElements(headerString)
                headerString = headerString.trimFromEnd("#")
                
                //some # char has been trimmed
                if countElements(headerString) < headerLength {
                    
                    if headerString[advance(headerString.endIndex, -1)] != " " {
                        
                        for var i = 0;i < headerLength - countElements(headerString);i++ {
                            
                            headerString += "#"
                            
                        }
                        
                    }else{
                        headerString = headerString.trimFromEnd(" ")
                    }
                    
                }
                
                var headerNode:ATXHeader = ATXHeader(content: headerString, level: level)
                return headerNode;

                
            }
            
        }
        
        return nil
        
    }
    
    private func parseHr(curLine: String) -> HorizontalRule? {
        
        if curLine.leadingSpaces() >= 4 {
            return nil
        }
        
        var filtedLine = curLine.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.allZeros, range: nil)
        
        let hrChar1:Character = "-"
        let hrChar2:Character = "*"
        let hrChar3:Character = "_"
        
        if (filtedLine.countOfChar(hrChar1) >= 3 && filtedLine.countOfChar(hrChar1) == countElements(filtedLine)) ||
            (filtedLine.countOfChar(hrChar2) >= 3 && filtedLine.countOfChar(hrChar2) == countElements(filtedLine)) ||
            (filtedLine.countOfChar(hrChar3) >= 3 && filtedLine.countOfChar(hrChar3) == countElements(filtedLine)) {
                
                var hr:HorizontalRule = HorizontalRule(content: curLine)
                return hr

                
        }else{
            return nil
        }
        
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
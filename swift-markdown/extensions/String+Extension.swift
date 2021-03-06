//
//  String+Extension.swift
//  swift-markdown
//
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation

extension String {
    
    func leadingSpaces() -> Int {
        
        var leadingNumber = 0
        
        for (index,char) in enumerate(self) {
           
            
            if char == " " {
                leadingNumber += 1
                
                if index == countElements(self) - 1 {
                    
                    return leadingNumber

                }
                
            }else{
                
                return leadingNumber
            }
            
        }
        
        return 0
    }
    
    func trimFromStart(pattern:String) -> String {

        
        var result:String = self;
        
        while let range:Range<String.Index> = result.rangeOfString(pattern) {

            if(distance(result.startIndex, range.startIndex) == 0){
            
                result = result.substringFromIndex(range.endIndex)

            }else{
                return result;
            }
            
        }
        
        return result;
        
    }
    
    func trimFromEnd(pattern:String) -> String {
        
        var result:String = self;
        
        while let range:Range<String.Index> = result.rangeOfString(pattern, options: NSStringCompareOptions.BackwardsSearch) {
            
            if result.endIndex == range.endIndex {
                
                result = result.substringToIndex(range.startIndex)
                
            }else{
                
                return result
                
            }
            
        }
        
        return result
        
    }
    
    func countOfChar(c:Character) -> Int {
        
        var count:Int = 0
        
        for char:Character in self {

            if char == c {
                
                count++
                
            }
            
        }
        
        return count
        
    }
    
    func numberOfLeadingChar(c:Character) -> Int {
        
        var count:Int = 0
        
        for char:Character in self {
            
            if char == c {
                
                count++
                
            }else{
                
                return count
                
            }
            
        }
        
        return count
        
    }
    
    func numberOfLines() -> Int {

        return self.componentsSeparatedByString("\n").count
        
    }
    
    func allCharIs(char: Character) -> Bool {
        
        return self.countOfChar(char) == countElements(self)
        
    }
    
    
    
}
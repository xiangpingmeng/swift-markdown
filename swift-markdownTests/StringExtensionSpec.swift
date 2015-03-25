//
//  StringExtensionSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/3/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class StringExtensionSpec: QuickSpec {
    
    override func spec() {
        
        describe("leading space") {
            
            it("normal") {
                
                expect("  aa".leadingSpaces()).to(equal(2))
                
            }
            
        }
        
        
        describe("trimFromStart"){
            
            it("normal") {
                
                expect("lloHe").to(equal("HelloHe".trimFromStart("He")));
                
            }
            
        }
        
        describe("trimFromEnd"){
            
            it("normal") {
                
                expect("HelloHe").to(equal("HelloHe###".trimFromEnd("#")));
                
            }
            
        }
        
        describe("countOfChars") {
            
            it("normal") {
  
                let c:Character = "l"
                expect("lloooe".countOfChar(c)).to(equal(2))
                
            }
            
        }
        
        describe("numberOfLeadingChar") {
            
            it("normal"){
                
                let c:Character = "#"
                expect("###test##".numberOfLeadingChar(c)).to(equal(3))
                
            }
            
        }
        
        describe("numberOfLines"){
            
            it("normal"){
                
                var str = "aa\nbb\ncc"
                expect(str.numberOfLines()).to(equal(3))
                
                str = "aa\n"
                expect(str.numberOfLines()).to(equal(1))
                
            }
            
        }
        
    }
    
}
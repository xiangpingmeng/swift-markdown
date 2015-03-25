//
//  LeafBlockSetextHeaderSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/25/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class LeafBlockSetextHeaderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Setext Header"){
            
            it("Simple example") {
                
                //example 41
                //Foo *bar*
                
//                var markdown = Markdown(document: "Foo *bar*")
//                expect(markdown.htmlString()).to(equal(""))
                
            }
            
            it("The underlining can be any length"){
                
                var markdown = Markdown(document: "Foo\n-------------------------")
                expect(markdown.htmlString()).to(equal("<h2>Foo</h2>"))
                
            }
            
        }
        
    }
    
}
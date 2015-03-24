//
//  LeafBlockATXHeadersSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/24/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class LeafBlockATXHeadersSpec : QuickSpec {

    override func spec() {
        
        describe("ATX Headers"){
            
            it("Simple headers"){
                
                //example 23
                var markdown = Markdown(document: "# foo")
                expect(markdown.htmlString()).to(equal("<h1>foo</h1>"))
                
                markdown = Markdown(document: "## foo")
                expect(markdown.htmlString()).to(equal("<h2>foo</h2>"))
                
                markdown = Markdown(document: "### foo")
                expect(markdown.htmlString()).to(equal("<h3>foo</h3>"))
                
                markdown = Markdown(document: "#### foo")
                expect(markdown.htmlString()).to(equal("<h4>foo</h4>"))
                
                markdown = Markdown(document: "##### foo")
                expect(markdown.htmlString()).to(equal("<h5>foo</h5>"))
                
                markdown = Markdown(document: "###### foo")
                expect(markdown.htmlString()).to(equal("<h6>foo</h6>"))

                
            }
            
            it("More than six # characters is not a header") {
                
                //example 24
                var markdown = Markdown(document: "####### foo")
                expect(markdown.htmlString()).to(equal("<p>####### foo</p>"))
                
            }
            
            it("A space is required between the # characters and the header's contents."){
                
                // Note that many implementations currently do not require the space. 
                //However, the space was required by the original ATX implementation, 
                //and it helps prevent things like the following from being parsed as headers:
                
                //example 25
                
                var markdown = Markdown(document: "#5 bolt")
                expect(markdown.htmlString()).to(equal("<p>#5 bolt</p>"))
                
            }
            
//            it("This is not a header, because the first # is escaped") {
//                
//                //example 26
//                var markdown = Markdown(document: "\\## foo")
//                expect(markdown.htmlString()).to(equal("<p>## foo</p>"))
//                
//            }
            
            it("Leading and trailing blanks are ignored in parsing inline content") {
                
                var markdown = Markdown(document: "#                  foo                     ")
                expect(markdown.htmlString()).to(equal("<h1>foo</h1>"))
                
            }
            
        }
        
    }
    
}
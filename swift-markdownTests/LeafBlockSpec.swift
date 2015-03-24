//
//  LeafBlockSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/2/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble


// Mark: according to http://spec.commonmark.org/0.17/#leaf-blocks

class LeafBlockSpec: QuickSpec {
    
    var markdown:Markdown?

    override func spec() {
        
        describe("Horizonal Rule") {
            
            //example 4
            it("normal case") {
                
                self.markdown = Markdown(document: "***")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "---")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "___")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
            }
            
            //example 5
            //example 6
            it("wrong character") {
                
                self.markdown = Markdown(document: "+++")
                expect(self.markdown!.htmlString()).to(equal("<p>+++</p>"))
                
                self.markdown = Markdown(document: "===")
                expect(self.markdown!.htmlString()).to(equal("<p>===</p>"))
                
                
            }
            
            //example 7
            it("Not enough characters") {
                
                var mardownString:String = "--\n" +
                    "**\n" +
                    "__"
                self.markdown = Markdown(document: mardownString)
                expect(self.markdown!.htmlString()).to(equal(
                    "<p>--\n" +
                    "**\n" +
                    "__</p>"))
                
            }
            
            //example 8
            it("One to three spaces indent are allowed") {
                
                self.markdown = Markdown(document: " ***")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "  ***")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "   ***")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
            }
            



            it("Spaces are allowed between the characters:"){

                //example 12
                self.markdown = Markdown(document: " - - -")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))

                //example 13
                self.markdown = Markdown(document: " **  * ** * ** * **")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                //example 14
                self.markdown = Markdown(document: "-     -      -      -")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
            }
            
            it("Spaces are allowed at the end"){
                
                //example 15
                self.markdown = Markdown(document: "- - - -    ")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
            }
            
            it("However, no other characters may occur in the line"){
                
                //example 16
                //_ _ _ _ a
                //
                //a------
                //
                //---a---
                //shoud be
                //<p>_ _ _ _ a</p>
                //<p>a------</p>
                //<p>---a---</p>
                
                self.markdown = Markdown(document: "_ _ _ _ a\n" +
                    "\n" +
                    "a------\n" +
                    "\n" +
                   " ---a---")
                expect(self.markdown!.htmlString()).to(equal("<p>_ _ _ _ a</p>\n" +
                    "<p>a------</p>\n" +
                    "<p>---a---</p>"))
                
            }
            
            it("Horizonal rules can interrupt paragraph") {
                
                //example 19
                //Foo
                //***
                //bar
                //should be
                //<p>Foo</p>
                //<hr />
                //<p>bar</p>
                
                self.markdown = Markdown(document: "Foo\n***\nbar")
                expect(self.markdown!.htmlString()).to(equal("<p>Foo</p>\n<hr />\n<p>bar</p>"))
                
            }
            
        }        
        
        
    }
    
}
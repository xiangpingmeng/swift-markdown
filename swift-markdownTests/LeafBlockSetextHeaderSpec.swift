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
                
                //example 42
                //Foo
                //-------------------------
                //
                //Foo
                //=
                //should be 
                //<h2>Foo</h2>
                //<h1>Foo</h1>
                var markdown = Markdown(document: "Foo\n-------------------------\n\nFoo\n=")
                expect(markdown.htmlString()).to(equal("<h2>Foo</h2>\n<h1>Foo</h1>"))
                
            }
            
            it("The header content can be indented up to three spaces, and need not line up with the underlining") {
                
                //   Foo
                //---
                //
                //Foo
                //-----
                //
                //Foo
                //===
                //should be
                //<h2>Foo</h2>
                //<h2>Foo</h2>
                //<h1>Foo</h1>
                
                var markdown = Markdown(document: "   Foo\n---\n\n  Foo\n-----\n\n  Foo\n  ==")
                expect(markdown.htmlString()).to(equal("<h2>Foo</h2>\n<h2>Foo</h2>\n<h1>Foo</h1>"))
                
                
            }
            
            it("The setext header underline can be indented up to three spaces, and may have trailing spaces"){
                
                //example 45
                //Foo
                //   ----      
                //shoule be 
                //<h2>Foo</h2>
                
                var markdown = Markdown(document: "Foo\n   ----      ")
                expect(markdown.htmlString()).to(equal("<h2>Foo</h2>"))
                
                
            }
            
            it("Four spaces is too much") {
                
                //example 46
                //Foo
                //    ---
                //should be
                //<p>Foo
                //---</p>
                
                var markdown = Markdown(document: "Foo\n    ---")
                expect(markdown.htmlString()).to(equal("<p>Foo\n---</p>"))
                
            }
            it("The setext header underline cannot contain internal spaces"){
                
                //example 47
                //Foo
                //= =
                //
                //Foo
                //--- -
                //shoule be
                //<p>Foo
                //= =</p>
                //<p>Foo</p>
                //<hr />
                var markdown = Markdown(document: "Foo\n= =\n\nFoo\n--- -")
                expect(markdown.htmlString()).to(equal("<p>Foo\n= =</p>\n<p>Foo</p>\n<hr />"))
                
            }
            
            it("Trailing spaces in the content line do not cause a line break"){
                
                //example 48
                //Foo  
                //-----
                //should be 
                //<h2>Foo</h2>
                
                var markdown = Markdown(document: "Foo  \n-----")
                expect(markdown.htmlString()).to(equal("<h2>Foo</h2>"))
                
            }
            
            it("Nor does a backslash at the end") {
                
                //example 49
                //Foo\
                //----
                //should be
                //<h2>Foo\</h2>
                var markdown = Markdown(document: "Foo\\\n----")
                expect(markdown.htmlString()).to(equal("<h2>Foo\\</h2>"))
                
            }
            it("A setext header cannot interrupt a paragraph") {
                
                //example 53
                //Foo
                //Bar
                //---
                //
                //Foo
                //Bar
                //===
                //should be 
                //<p>Foo
                //Bar</p>
                //<hr />
                //<p>Foo
                //Bar
                //===</p>
                
                var markdown = Markdown(document: "Foo\nBar\n---\n\nFoo\nBar\n===")
                expect(markdown.htmlString()).to(equal("<p>Foo\nBar</p>\n<hr />\n<p>Foo\nBar\n===</p>"))
                
            }
            
            
            it("But in general a blank line is not required before or after") {
                
                //example 54
                //---
                //Foo
                //---
                //Bar
                //---
                //Baz
                //should be
                //<hr />
                //<h2>Foo</h2>
                //<h2>Bar</h2>
                //<p>Baz</p>
                
                var markdown = Markdown(document: "---\nFoo\n---\nBar\n---\nBaz")
                expect(markdown.htmlString()).to(equal("<hr />\n<h2>Foo</h2>\n<h2>Bar</h2>\n<p>Baz</p>"))
                
            }
            
            it("Setext header cannot be empty") {
                
                //example 55
                //
                //====
                //should be
                //<p>====</p>
                
                var markdown = Markdown(document: "\n====")
                expect(markdown.htmlString()).to(equal("<p>====</p>"))
                
            }
            
            it("Setext header text lines must not be interpretable as block constructs other than paragraph. So the lin of dashes in these examples gets interpreted as a horizonal rule") {
                
                //example 56
                //---
                //---
                //should be 
                //<hr />
                //<hr />
                var markdown = Markdown(document: "---\n---")
                expect(markdown.htmlString()).to(equal("<hr />\n<hr />"))
                
                //example 57
                //- foo
                //-----
                
                
            }
            
        }
        
    }
    
}
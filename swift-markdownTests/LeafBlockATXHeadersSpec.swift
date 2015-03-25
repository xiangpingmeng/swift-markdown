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
                
                //example 28
                var markdown = Markdown(document: "#                  foo                     ")
                expect(markdown.htmlString()).to(equal("<h1>foo</h1>"))
                
            }
            
            it("One to three spaces indentation are allowed") {
                
                //example 29
                var markdown = Markdown(document: " ### foo")
                expect(markdown.htmlString()).to(equal("<h3>foo</h3>"))
                
                markdown = Markdown(document: "  ## foo")
                expect(markdown.htmlString()).to(equal("<h2>foo</h2>"))
                
                markdown = Markdown(document: "   # foo")
                expect(markdown.htmlString()).to(equal("<h1>foo</h1>"))
                
            }
            
            it("Four spaces are too much"){
            
                
                //example 31
                var markdown = Markdown(document: "foo\n    # bar")
//              expect(markdown.htmlString()).to(equal("<p>foo\n# bar</p>"))
                
            }
            
            it("A closing sequence of # characters is optional"){
                
                
                //example 32
                //## foo ##
                //  ###   bar    ###
                //shoule be 
                //<h2>foo</h2>
                //<h3>bar</h3>
                
                var markdown = Markdown(document: "## foo ##\n  ###   bar    ##")
                expect(markdown.htmlString()).to(equal("<h2>foo</h2>\n<h3>bar</h3>"))
                
            }
            
            it("It need not be the same length as the opening sequence") {
                
                //example 33
                //# foo ##################################
                //##### foo ##
                //should be 
                //<h1>foo</h1>
                //<h5>foo</h5>
                var markdown = Markdown(document: "# foo ##################################\n##### foo ##")
                expect(markdown.htmlString()).to(equal("<h1>foo</h1>\n<h5>foo</h5>"))
                
                
            }
            
            it("Spaces are allowed after the closing sequence") {
                
                //example 34
                var markdown = Markdown(document: "### foo ###     ")
                expect(markdown.htmlString()).to(equal("<h3>foo</h3>"))
                
                
            }
            
            it("A sequence of # characters with a non-space character following it is not a closing sequence, but counts as part of the contents of the header") {
                
                //example 35
                var markdown = Markdown(document: "### foo ### b")
                expect(markdown.htmlString()).to(equal("<h3>foo ### b</h3>"))
                
            }
            
            it("the closing sequence must be preceded by a space") {
                
                //example 36
                var markdown = Markdown(document: "# foo#")
                expect(markdown.htmlString()).to(equal("<h1>foo#</h1>"))
                
            }
            
            it("ATX headers need not be separated from surrounding content by blank lines, and they can interrupt paragraphs") {
                
                //example 38
                //****
                //## foo
                //****
                //shoule be 
                //<hr />
                //<h2>foo</h2>
                //<hr />
                var markdown = Markdown(document: "****\n## foo\n****")
                expect(markdown.htmlString()).to(equal("<hr />\n<h2>foo</h2>\n<hr />"))
                
                
                //example 39
                //Foo bar
                //# baz
                //Bar foo
                //should be
                //<p>Foo bar</p>
                //<h1>baz</h1>
                //<p>Bar foo</p>
                markdown = Markdown(document: "Foo bar\n# baz\nBar foo")
                expect(markdown.htmlString()).to(equal("<p>Foo bar</p>\n<h1>baz</h1>\n<p>Bar foo</p>"))
                
                
            }
            
            it("ATX headers can be empty") {
                
                //example 40
                var markdown = Markdown(document: "## \n#\n### ###")
                expect(markdown.htmlString()).to(equal("<h2></h2>\n<h1></h1>\n<h3></h3>"))
                
            }
            
        }
        
    }
    
}
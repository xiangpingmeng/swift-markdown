//
//  IndentedCodeBlockSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/25/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class IndentedCodeBlockSpec: QuickSpec {

    override func spec() {
        
        describe("Indented code blocks"){
            
            it("simple block") {
                
                //example 61
                var markdown:Markdown = Markdown(document: "    a simple\n      indented code block")
                expect(markdown.htmlString()).to(equal("<pre><code>a simple\n  indented code block\n</code></pre>"))
                
            }
            
            it("The contents are literal text, and do not get parsed as Markdown"){
                
                //example 62
                
                
            }
            
            it("Here we have three chunks separated by blank lines") {
                
                //example 63
                //    chunk1
                //
                //    chunk2
                //__
                //_
                //_
                //    chunk3
                //should be
                //<pre><code>chunk1
                //
                //chunk2
                //
                //
                //
                //chunk3
                //</code></pre>
                
                var markdown = Markdown(document: "    chunk1\n\n    chunk2\n  \n \n \n    chunk3")
                expect(markdown.htmlString()).to(equal("<pre><code>chunk1\n\nchunk2\n\n\n\nchunk3\n</code></pre>"))
                
            }
            
            it("Any initial spaces beyond four will be included  in the content, even in interior blank lines") {
                
                //example 64
                //    chunk1
                //
                //      chunk2
                //should be
                //<pre><code>chunk1
                //  
                //  chunk2
                //</code></pre>
                
                var markdown = Markdown(document: "    chunk1\n      \n      chunk2")
                expect(markdown.htmlString()).to(equal("<pre><code>chunk1\n  \n  chunk2\n</code></pre>"))
                
            }
            
            it("An indented code block cannot interrupt a paragraph.(This allows hanging indents and the like)"){
                
                //example 65
                //Foo
                //    bar
                //should be 
                //<p>Foo
                //bar</p>
                
                var markdown = Markdown(document: "Foo\n    bar")
                expect(markdown.htmlString()).to(equal("<p>Foo\nbar</p>"))
                
            }
            
            it("However, any non-block line with fewer than four leading spaces ends the code block immediately. So a paragraph may occur immediately after indented code"){
                
                //example 66
                //    foo
                //bar
                //should be 
                //<pre><code>foo
                //</code></pre>
                //<p>bar</p>
                
                var markdown = Markdown(document: "    foo\nbar")
                expect(markdown.htmlString()).to(equal("<pre><code>foo\n</code></pre>\n<p>bar</p>"))
                
            }
            
            it("An indented code can occur immediately before and after other kinds of blocks"){
                
                //example 67
                
                //# Header
                //    foo
                //Header
                //------
                //    foo
                //----
                
                //<h1>Header</h1>
                //<pre><code>foo
                //</code></pre>
                //<h2>Header</h2>
                //<pre><code>foo
                //</code></pre>
                //<hr />
                
                var markdown = Markdown(document: "# Header\n    foo\nHeader\n------\n    foo\n----")
                expect(markdown.htmlString()).to(equal("<h1>Header</h1>\n<pre><code>foo\n</code></pre>\n<h2>Header</h2>\n<pre><code>foo\n</code></pre>\n<hr />"))
                
            }
            
            
            it("The first line can be indented more than four spaces") {
                
                //example 68
                
                //        foo
                //    bar
                
                //<pre><code>    foo
                //bar
                //</code></pre>
                
                var markdown = Markdown(document: "        foo\n    bar")
                expect(markdown.htmlString()).to(equal("<pre><code>    foo\nbar\n</code></pre>"))
                
            }
            
            it("Blank lines preceding or following an indented code block are not included in it"){
                
                //example 69
                
                //
                //____
                //    foo
                //____
                
                //<pre><code>foo
                //</code></pre>
                
                var markdown = Markdown(document: "\n    \n    foo\n    \n")
                expect(markdown.htmlString()).to(equal("<pre><code>foo\n</code></pre>"))
                
            }
            
            it("Trailing spaces are included in the code block's content") {
                
                //example 70
                
                //    foo   
                
                //<pre><code>foo__
                //</code></pre>
                
                var markdown = Markdown(document: "    foo  ")
                expect(markdown.htmlString()).to(equal("<pre><code>foo  \n</code></pre>"))
                
            }
            
        }
        
    }
    
}
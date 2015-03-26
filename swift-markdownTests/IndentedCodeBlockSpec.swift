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
            
        }
        
    }
    
}
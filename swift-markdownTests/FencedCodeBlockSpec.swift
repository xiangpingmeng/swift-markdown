//
//  FencedCodeBlock.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/27/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class FencedCodeBlockSpec : QuickSpec {
    
    override func spec() {
        
        describe("Fenced Code Block"){
        
            
            it("simple example with backticks"){
                
                //example 71
                
                //```
                //<
                // >
                //```
                
                //<pre><code>&lt;
                //_&gt;
                //</code></pre>
                
                var markdown = Markdown(document: "```\n<\n >\n```")
                expect(markdown.htmlString()).to(equal("<pre><code>&lt;\n &gt;\n</code></pre>"))
                
            }
            
            it("with tildes") {
                
                //example 72
                
                //~~~
                //<
                // >
                //~~~
                
                //<pre><code>&lt;
                //_&gt;
                //</code></pre>
                
                var markdown = Markdown(document: "~~~\n&lt;\n &gt;\n~~~")
                expect(markdown.htmlString()).to(equal("<pre><code>&lt;\n &gt;\n</code></pre>"))
                
            }
            
            it("The closing code fence must use the same character as the opening fence"){
                
                //example 73 
                
                //```
                //aaa
                //~~~
                //```
                
                //<pre><code>aaa
                //~~~
                //</code></pre>
                
                var markdown = Markdown(document: "```\naaa\n~~~\n```")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n~~~\n</code></pre>"))
                
                
                //example 74
                
                //~~~
                //aaa
                //```
                //~~~
                
                //<pre><code>aaa
                //```
                //</code></pre>
                
                markdown = Markdown(document: "~~~\naaa\n```\n~~~")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n```\n</code></pre>"))
                
            }
            
            it("The closing code fence must be at least as long as the opening fence"){
                
                //example 75
                
                //````
                //aaa
                //```
                //``````
                
                //<pre><code>aaa
                //```
                //</code></pre>
                
                var markdown = Markdown(document: "````\naaa\n```\n``````")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n```\n</code></pre>"))
                
                
                //example 76
                
                //~~~~
                //aaa
                //~~~
                //~~~~
                
                //<pre><code>aaa
                //~~~
                //</code></pre>
                
                markdown = Markdown(document: "~~~~\naaa\n~~~\n~~~~")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n~~~\n</code></pre>"))
                
            }
            
            
            it("Unclosed code blocks are closed by the end of the document") {
                
                //example 77
                //```
                
                //<pre><code></code></pre>
                
                var markdown = Markdown(document: "```")
                expect(markdown.htmlString()).to(equal("<pre><code></code></pre>"))
                
                
                //example 78
                
                //`````
                //
                //```
                //aaa
                
                //<pre><code>
                //```
                //aaa
                //</code></pre>
                
                markdown = Markdown(document: "`````\n\n```\naaa")
                expect(markdown.htmlString()).to(equal("<pre><code>\n```\naaa\n</code></pre>"))
                
            }
            
            it("a code block can have all empty lines as it content"){
                
                //example 79
                
                //```
                //
                //__
                //```
                
                //<pre><code>
                //__
                //</code></pre>
                
                var markdown = Markdown(document: "```\n\n  \n```")
                expect(markdown.htmlString()).to(equal("<pre><code>\n  \n</code></pre>"))
                
            }
            
            it("A code block can be empty"){
                
                //example 80
                
                //```
                //```
                
                //<pre><code></code></pre>
                
                var markdown = Markdown(document: "```\n```")
                expect(markdown.htmlString()).to(equal("<pre><code></code></pre>"))
                
            }
            
        }
        
    }
    
}
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
            
            it("Fences can be indented. If the opening fence is indented, content lines will have equivalent opening indention removed, if present") {
                
                //example 81
                
                // ```
                // aaa
                //aaa
                //```
                
                //<pre><code>aaa
                //aaa
                //</code></pre>
                
//                var markdown = Markdown(document: " ```\n aaa\naaa\n```")
//                expect(markdown.htmlString()).to(equal("<pre><code>aaa\naaa\n</code></pre>"))
                
                
                //example 82
                
                //__```
                //aaa
                //__aaa
                //aaa
                //__```
                
                //<pre><code>aaa
                //aaa
                //aaa
                //</code></pre>
                
//                markdown = Markdown(document: "  ```\naaa\n  aaa\naaa\n  ```")
//                expect(markdown.htmlString()).to(equal("<pre><code>aaa\naaa\naaa\n</code></pre>"))
                
                
                //example 83
                
                //___```
                //___aaa
                //____aaa
                //__aaa
                //___```
                
                //<pre><code>aaa
                //_aaa
                //aaa
                //</code></pre>
                
                var markdown = Markdown(document: "   ```\n   aaa\n    aaa\n  aaa\n   ```")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n aaa\naaa\n</code></pre>"))
                
            }
            
            it("Four spaces indentation produces an indented code block"){
                
                //example 84
                
                //____```
                //____aaa
                //____```
                
                //<pre><code>```
                //aaa
                //```
                //</code></pre>
                
                var markdown = Markdown(document: "    ```\n    aaa\n    ```")
                expect(markdown.htmlString()).to(equal("<pre><code>```\naaa\n```\n</code></pre>"))
                
            }
            
            it("Closing fences may be indented by 0-3 spaces, and their indentation need not match that of the opening fence") {
                
                //example 85
                
                //```
                //aaa
                //__```
                
                //<pre><code>aaa
                //</code></pre>
                
                var markdown = Markdown(document: "```\naaa\n  ```")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n</code></pre>"))
                
                
                //example 86
                
                //___```
                //aaa
                //  ```
                
                //<pre><code>aaa
                //</code></pre>
                
                markdown = Markdown(document: "   ```\naaa\n  ```")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n</code></pre>"))
                
            }
            
            it("This is not a closing fence, because it is indented 4 spaces"){
                
                //example 87
                
                //```
                //aaa
                //____```
                
                //<pre><code>aaa
                //____```
                //</code></pre>
                
                var markdown = Markdown(document: "```\naaa\n    ```")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n    ```\n</code></pre>"))
                
            }
            
            it("Code fences(opening and closing) cannot contain internal spaces") {
                
                //example 89
                
                //~~~~~~
                //aaa
                //~~~ ~~
                
                //<pre><code>aaa
                //~~~ ~~
                //</code></pre>
                
                var markdown = Markdown(document: "~~~~~~\naaa\n~~~ ~~")
                expect(markdown.htmlString()).to(equal("<pre><code>aaa\n~~~ ~~\n</code></pre>"))
                
            }
            
            it("Fenced code blocks can interrupt paragraphs, and can be followed directly by pargraphs, without a blank line between"){
                
                //example 90
                
                //foo
                //```
                //bar
                //```
                //baz
                
                //<p>foo</p>
                //<pre><code>bar
                //</code></pre>
                //<p>baz</p>
                
                var markdown = Markdown(document: "foo\n```\nbar\n```\nbaz")
                expect(markdown.htmlString()).to(equal("<p>foo</p>\n<pre><code>bar\n</code></pre>\n<p>baz</p>"))
                
            }
            
            it("Other blocks can also occur before and after fenced code blocks without an intervening blank line") {
                
                //example 91
                
                //foo
                //---
                //~~~
                //bar
                //~~~
                //# baz
                
                //<h2>foo</h2>
                //<pre><code>bar
                //</code></pre>
                //<h1>baz</h1>
                
                var markdown = Markdown(document: "foo\n---\n~~~\nbar\n~~~\n# baz")
                expect(markdown.htmlString()).to(equal("<h2>foo</h2>\n<pre><code>bar\n</code></pre>\n<h1>baz</h1>"))
                
            }
            
            
            it("An info string can be provided after the opening code fence. Opening and closing spaces will be stripped, and the first word, prefixed with language-, is used as the value for the class attribute of the code element within the enclosing pre element"){
                
                //example 92
                //```ruby
                //def foo(x)
                //  return 3
                //end
                //```
                
                //<pre><code class="language-ruby">def foo(x)
                // return 3
                //end
                //</code></pre>
                
                var markdown = Markdown(document: "```ruby\ndef foo(x)\n  return 3\nend\n```")
                expect(markdown.htmlString()).to(equal("<pre><code class=\"language-ruby\">def foo(x)\n  return 3\nend\n</code></pre>"))
                
            }
            
        }
        
    }
    
}
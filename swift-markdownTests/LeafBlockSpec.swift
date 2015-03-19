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

class LeafBlockSpec: QuickSpec {
    
    var markdown:Markdown?

    override func spec() {
        
        describe("hr") {
            
            //example 4
            it("normal case") {
                
                self.markdown = Markdown(document: "***")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "---")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
                self.markdown = Markdown(document: "___")
                expect(self.markdown!.htmlString()).to(equal("<hr />"))
                
            }
            
            
            it("wrong character") {
                
                self.markdown = Markdown(document: "+++")
                expect(self.markdown!.htmlString()).to(equal("<p>+++</p>"))
                
                self.markdown = Markdown(document: "===")
                expect(self.markdown!.htmlString()).to(equal("<p>===</p>"))
                
                
            }
            
        }
        
        
    }
    
}
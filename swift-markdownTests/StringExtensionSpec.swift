//
//  StringExtensionSpec.swift
//  swift-markdown
//
//  Created by mengxiangping on 3/3/15.
//  Copyright (c) 2015 swiftcafe. All rights reserved.
//

import Foundation
import Quick
import Nimble

class StringExtensionSpec: QuickSpec {
    
    override func spec() {
        
        describe("leading space") {
            
            it("normal") {
                
                expect("  aa".leadingSpaces()).to(equal(2))
                
            }
            
        }
        
    }
    
}
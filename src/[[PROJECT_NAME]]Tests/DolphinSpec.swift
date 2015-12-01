//
//  DolphinSpec.swift
//  [[PROJECT_NAME]]
//
// Example Quick and Nimble test file

import Quick
import Nimble

class DolphinSpec: QuickSpec {
    override func spec() {
        
        describe("a dolphin") {
            
            beforeEach {
                
            }
            
            describe("click") {
                context("When it's not near anything") {
                    it ("emits only one click") {
                        expect(true).to(equal(true))
                    }
                }
            }
        }
    }
}

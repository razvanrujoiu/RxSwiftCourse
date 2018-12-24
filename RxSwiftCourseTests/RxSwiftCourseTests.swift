//
//  RxSwiftCourseTests.swift
//  RxSwiftCourseTests
//
//  Created by Razvan Rujoiu on 23/12/2018.
//  Copyright © 2018 Rujoiu Razvan. All rights reserved.
//

import XCTest
@testable import RxSwiftCourse

class RxSwiftCourseTests: XCTestCase {

    var vc: ViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        assert(vc.movies.count == 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

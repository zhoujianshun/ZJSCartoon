//
//  ZJSCartoonTests.m
//  ZJSCartoonTests
//
//  Created by 周建顺 on 2019/1/3.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface ZJSCartoonTests : XCTestCase

@property (nonatomic, strong) ViewController *vc;

@end

@implementation ZJSCartoonTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testSum1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int result = [self.vc sum:1 b:1];
    XCTAssert(result == 2, @"error 1 + 1 = 2");
    
}

- (void)testSum2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int result = [self.vc sum:1 b:2];
    XCTAssert(result != 2, @"error 1 + 2 != 2");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

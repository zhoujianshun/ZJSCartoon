//
//  ZJSCarttonApiTest.m
//  ZJSCartoonTests
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZJSGetAllCartoonsRequestApi.h"

@interface ZJSCarttonApiTest : XCTestCase

@end

@implementation ZJSCarttonApiTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testGetAllCarttons{
    ZJSGetAllCartoonsRequestApi *api = [[ZJSGetAllCartoonsRequestApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        XCTAssertNotNil(request.responseObject,@"ZJSGetAllCartoonsRequestApi数据为空");
        ZJS_TEST_NOTIFY
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        XCTFail(@"ZJSGetAllCartoonsRequestApi请求错误：%@", request.error);
        ZJS_TEST_NOTIFY
    }];
    ZJS_TEST_WAIT
}

@end

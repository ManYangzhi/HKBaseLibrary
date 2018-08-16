//
//  HKSampleTests.m
//  HKSampleTests
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"
#import "HKHomeViewController.h"
#import <OCMock/OCMock.h>
#import <KVOController/FBKVOController.h>
#import <KVOController/NSObject+FBKVOController.h>

@interface HKSampleTests : XCTestCase

@end

@implementation HKSampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testHTTPMock {
    NSString *urlString = @"https://idont.know";
    NSString *path = OHPathForFileInBundle(@"stub.txt", [NSBundle mainBundle]);
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:urlString];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse
                responseWithFileAtPath:path
                statusCode:200
                headers:@{@"Content-type":@"application/json"}];
    }];
    
    HKHomeViewController *vcl = [HKHomeViewController new];
    [vcl viewDidLoad];
    
    
}

@end

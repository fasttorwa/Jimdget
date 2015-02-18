//
//  UserDefaultsTests.m
//  JimdgetTests
//
//  Created by Marius on 13/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "JMDUserDefaultsManager.h"

NSString *const kUserDefaultsTestKey = @"userDefaultsTestKey";
NSString *const kUserDefaultsTestObj = @"userDefaultsTestObj";

@interface UserDefaultsTests : XCTestCase

@end


@implementation UserDefaultsTests

- (void)setUp
{
    [super setUp];

    [JMDUserDefaultsManager removeObjectForKey: kUserDefaultsTestKey fromStore: UserDefaultsStoreStandard];
    [JMDUserDefaultsManager removeObjectForKey: kUserDefaultsTestKey fromStore: UserDefaultsStoreAppGroup];
}


- (void)tearDown
{
    [super tearDown];
}


- (void)testWriteUserDefaultsStoreAppGroup
{
    XCTAssert([JMDUserDefaultsManager setObject: kUserDefaultsTestObj forKey: kUserDefaultsTestKey toStore: UserDefaultsStoreAppGroup], @"Synchronize returned NO");
}


- (void)testReadUserDefaultsStoreAppGroup
{
    [JMDUserDefaultsManager setObject: kUserDefaultsTestObj forKey: kUserDefaultsTestKey toStore: UserDefaultsStoreAppGroup];
    id object = [JMDUserDefaultsManager objectForKey: kUserDefaultsTestKey fromStore: UserDefaultsStoreAppGroup];
    XCTAssertNotNil(object, @"Object from app group store is nil");
}


- (void)testWriteUserDefaultsStoreStandard
{
    XCTAssert([JMDUserDefaultsManager setObject: kUserDefaultsTestObj forKey: kUserDefaultsTestKey toStore: UserDefaultsStoreStandard], @"Synchronize returned NO");
}


- (void)testReadUserDefaultsStoreStandard
{
    [JMDUserDefaultsManager setObject: kUserDefaultsTestObj forKey: kUserDefaultsTestKey toStore: UserDefaultsStoreStandard];
    id object = [JMDUserDefaultsManager objectForKey: kUserDefaultsTestKey fromStore: UserDefaultsStoreStandard];
    XCTAssertNotNil(object, @"Object from standard store is nil");
}



@end

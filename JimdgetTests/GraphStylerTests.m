//
//  GraphStylerTests.m
//  Jimdget
//
//  Created by Marius on 19/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "JMDGraphStyler.h"

@interface GraphStylerTests : XCTestCase

@end

@implementation GraphStylerTests

- (void)setUp
{
    [super setUp];
}


- (void)tearDown
{
    [super tearDown];
}


- (void)testStylesAvailable
{
    NSDictionary *stylesMap = [JMDGraphStyler stylesMap];
    XCTAssertGreaterThan(stylesMap.count, 0, @"No Styles in StyleMap");
}


- (void)testStylesWithNoAttributes
{
    NSDictionary *stylesMap = [JMDGraphStyler stylesMap];
    for (NSString *styleName in stylesMap)
    {
        NSDictionary *styleDict = [stylesMap objectForKey: styleName];
        XCTAssertGreaterThan(styleDict.count, 0, @"No Attributes in Style %@", styleName);
    }
}



@end

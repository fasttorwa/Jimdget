//
//  JMDGraphDataProvider.m
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "JMDGraphDataProvider.h"

#import "NSDate+Weekday.h"


@implementation JMDGraphDataProvider


# pragma mark - SimpleLineGraph DataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return self.pointValues.count;
}


- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    CGFloat value = ((NSNumber *)self.pointValues[index]).floatValue;
    return value;
}


# pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 0;
}


- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index
{
    if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString: @"de"])
    {
        return [self weekdayTrimmedTo: 2 forIndex: index];
    }
    
    return [self weekdayTrimmedTo: 3 forIndex: index];
}


# pragma mark - Private

- (NSString *)weekdayTrimmedTo: (NSUInteger)length forIndex: (NSInteger)index
{
    NSTimeInterval dayInSeconds = 60 * 60 * 24;
    NSString *weekday = [NSDate  weekdayByAddingTimeInterval: dayInSeconds * (index + 1)];
    
    if (weekday.length > length)
    {
        return [weekday substringToIndex: length];
    }
    
    return weekday;
}


@end

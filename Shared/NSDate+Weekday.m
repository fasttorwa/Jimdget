//
//  NSDate+Weekday.m
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "NSDate+Weekday.h"

@implementation NSDate (Weekday)

+ (NSDate *)tomorrow
{
    NSTimeInterval dayInSeconds = 60 * 60 * 24;
    return [[NSDate date] dateByAddingTimeInterval: dayInSeconds];
}


+ (NSDate *)yesterday
{
    NSTimeInterval dayInSeconds = 60 * 60 * 24;
    return [[NSDate date] dateByAddingTimeInterval: -dayInSeconds];
}


+ (NSString *)weekdayByAddingTimeInterval: (NSTimeInterval)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"EEEE"];
    NSDate *now = [NSDate date];
    NSDate *newDate = [now dateByAddingTimeInterval: timeInterval];
    
    return [dateFormatter stringFromDate: newDate];
}


@end

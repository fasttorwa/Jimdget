//
//  NSDate+Weekday.h
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Weekday)

+ (NSDate *)tomorrow;
+ (NSDate *)yesterday;
+ (NSString *)weekdayByAddingTimeInterval: (NSTimeInterval)timeInterval;

@end

//
//  RandomDataProvider.m
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "RandomDataProvider.h"

#import "JMDUserDefaultsManager.h"
#import "Const.h"


@implementation RandomDataProvider

+ (void)writeTestDataToSharedStore
{
    long max = 100;
    
    NSArray *keys = @[kHitsKey, kVisitsKey];

    NSArray *hits = @[@([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]),
                      @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max])];
    
    NSArray *visits = @[@([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]),
                        @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max]), @([self randomIntegerUpTo: max])];
    
    [JMDUserDefaultsManager setObject: keys forKey: kKeysKey toStore: UserDefaultsStoreAppGroup];
    [JMDUserDefaultsManager setObject: hits forKey: kHitsKey toStore: UserDefaultsStoreAppGroup];
    [JMDUserDefaultsManager setObject: visits forKey: kVisitsKey toStore: UserDefaultsStoreAppGroup];
}


+ (NSInteger)randomIntegerUpTo: (long)max
{
    NSInteger i1 = (int)(arc4random() % max);
    return i1;
}

@end

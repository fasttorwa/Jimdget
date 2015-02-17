//
//  JMDUserDefaultsManager.h
//  Jimdget
//
//  Created by Marius on 14/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserDefaultsStore) {
    UserDefaultsStoreStandard,
    UserDefaultsStoreAppGroup
};


@interface JMDUserDefaultsManager : NSObject

+ (BOOL)setObject: (id)object forKey: (NSString *)key toStore: (UserDefaultsStore)storeType;
+ (id)objectForKey: (NSString *)key fromStore: (UserDefaultsStore)storeType;

@end

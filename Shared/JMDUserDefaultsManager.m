//
//  JMDUserDefaultsManager.m
//  Jimdget
//
//  Created by Marius on 14/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "JMDUserDefaultsManager.h"

NSString *const kCFBundlePackageType    = @"CFBundlePackageType";
NSString *const kBundleTypeApp          = @"APPL";


@implementation JMDUserDefaultsManager

+ (BOOL)setObject: (id)object forKey: (NSString *)key toStore: (UserDefaultsStore)storeType
{
    NSUserDefaults *userDefaults = [self defaultsStoreWithType: storeType];
    [userDefaults setObject: object forKey: key];

    return [userDefaults synchronize];
}


+ (id)objectForKey: (NSString *)key fromStore: (UserDefaultsStore)storeType
{
    NSUserDefaults *userDefaults = [self defaultsStoreWithType: storeType];
    
    return [userDefaults objectForKey: key];
}


#pragma mark - private

+ (NSUserDefaults *)defaultsStoreWithType: (UserDefaultsStore)storeType
{
    NSUserDefaults *userDefaults;
    
    switch (storeType)
    {
        case UserDefaultsStoreAppGroup:
            userDefaults = [[NSUserDefaults alloc] initWithSuiteName: [self appGroupIdentifier]];
            break;
        default:
            userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return userDefaults;
}


+ (NSString *)appGroupIdentifier
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *bundleIdentifier = mainBundle.bundleIdentifier;
    NSString *bundleNameKey = [mainBundle.infoDictionary objectForKey: (NSString *)kCFBundleNameKey]; // varies between App and Extension
    NSString *bundleType = [mainBundle.infoDictionary objectForKey: kCFBundlePackageType];
    NSRange nameKeyRange = [bundleIdentifier rangeOfString: bundleNameKey];
    
    NSString *appGroupIdentifier = bundleIdentifier;
    
    if (![bundleType isEqualToString: kBundleTypeApp] && nameKeyRange.length > 0)
    {
        if (nameKeyRange.location > 1)
        {
            appGroupIdentifier = [bundleIdentifier substringToIndex: nameKeyRange.location - 1];
        }
    }
    
    appGroupIdentifier = [NSString stringWithFormat: @"group.%@", appGroupIdentifier];
    
    return appGroupIdentifier;
}

@end

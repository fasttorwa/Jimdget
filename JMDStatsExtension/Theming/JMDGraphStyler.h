//
//  JMDGraphStyler.h
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BEMSimpleLineGraphView.h"


NSString *const kGraphStyleHits;
NSString *const kGraphStyleVisits;


typedef NS_ENUM(NSInteger, GraphStyle) {
    GraphStyleHits,
    GraphStyleVisits
};


@interface JMDGraphStyler : NSObject

+ (BEMSimpleLineGraphView *)styledGraph: (BEMSimpleLineGraphView *)graphView withStyle: (GraphStyle)style;
+ (NSDictionary *)stylesMap;


@end

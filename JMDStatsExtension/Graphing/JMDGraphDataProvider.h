//
//  JMDGraphDataProvider.h
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BEMSimpleLineGraphView.h"


@interface JMDGraphDataProvider : NSObject <BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>

@property (copy) NSArray *pointValues;

@end

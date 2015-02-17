//
//  JMDWidgetView.h
//  Jimdget
//
//  Created by Marius on 15/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BEMSimpleLineGraphView.h"


@interface JMDWidgetView : UIView

@property (nonatomic) id<BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource> hitsGraphDataProvider;
@property (nonatomic) id<BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource> visitsGraphDataProvider;

- (void)reload;

@end

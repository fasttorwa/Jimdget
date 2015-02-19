//
//  JMDGraphStyler.m
//  Jimdget
//
//  Created by Marius on 16/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "JMDGraphStyler.h"

#import "UIColor+MoreColor.h"


NSString *const kGraphStyleHits = @"GraphStyleHits";
NSString *const kGraphStyleVisits = @"GraphStyleVisits";

@implementation JMDGraphStyler

+ (BEMSimpleLineGraphView *)styledGraph: (BEMSimpleLineGraphView *)graphView withStyle: (GraphStyle)style
{
    NSDictionary *styleDict;
    switch (style)
    {
        case GraphStyleHits:
            styleDict = [[self stylesMap] objectForKey: kGraphStyleHits];
            break;
            
        case GraphStyleVisits:
            styleDict = [[self stylesMap] objectForKey: kGraphStyleVisits];
            break;
            
        default:
            styleDict = [[self stylesMap] objectForKey: kGraphStyleHits];
            break;
    }
    
    return [self applyStyle: styleDict toGraph: graphView];
}


# pragma mark - Privte

+ (BEMSimpleLineGraphView *)applyStyle: (NSDictionary *)styleDict toGraph: (BEMSimpleLineGraphView *)graphView
{
    for (NSString *key in styleDict)
    {
        [graphView setValue: [styleDict valueForKey: key] forKey: key];
    }
    
    // Gradient TODO: (CFObjects need boxing for dict to make gradient stylable)
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        0.9, 0.9, 1.0, 1.0, // RGBA
        0.9, 0.8, 1.0, 0.0
    };
    graphView.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    CGColorSpaceRelease(colorspace); // clang: false positive?
    
    return graphView;
}


# pragma mark - Styling

+ (NSDictionary *)stylesMap
{
    // not complete, see BEMSimpleLineGraphView.h for more properties
    return @{
             // ===== Default/Hits Style =====
             kGraphStyleHits :
                 @{
                     // Area above graph
                     @"alphaTop"                     : @0.0,
                     
                     // Area below Graph
                     @"colorBottom"                  : [UIColor jimdoLikeBlueColor],
                     
                     // Curve
                     @"widthLine"                    : @2.0,
                     @"enableBezierCurve"            : @NO,
                     @"alwaysDisplayDots"            : @YES,
                     @"colorLine"                    : [UIColor whiteColor],
                     @"colorXaxisLabel"              : [UIColor lightGrayColor],
                     @"colorYaxisLabel"              : [UIColor whiteColor],
                     
                     // Axis
                     @"enableYAxisLabel"             : @YES,
                     @"autoScaleYAxis"               : @YES,
                     @"enableReferenceYAxisLines"    : @YES,
                     @"enableReferenceAxisFrame"     : @YES,
                     @"alphaBackgroundXaxis"         : @0.0,
                     @"alphaBackgroundYaxis"         : @0.0,
                     
                     // Animation
                     @"animationGraphStyle"          : @(BEMLineAnimationDraw)
                  },
             
             
             // ===== Visits Style =====
             kGraphStyleVisits :
                 @{
                     // Area above graph
                     @"alphaTop"                     : @0.0,
                     
                     // Area below Graph
                     @"colorBottom"                  : [UIColor colorWithRed: 0.1 green: 0.92 blue: 0.25 alpha: 0.7],
                     
                     // Curve
                     @"widthLine"                    : @3.0,
                     @"enableBezierCurve"            : @NO,
                     @"alwaysDisplayDots"            : @YES,
                     @"colorLine"                    : [UIColor greenColor],
                     @"colorXaxisLabel"              : [UIColor lightGrayColor],
                     @"colorYaxisLabel"              : [UIColor whiteColor],
                     
                     // Axis
                     @"enableYAxisLabel"             : @YES,
                     @"autoScaleYAxis"               : @YES,
                     @"enableReferenceYAxisLines"    : @YES,
                     @"enableReferenceAxisFrame"     : @YES,
                     @"alphaBackgroundXaxis"         : @0.0,
                     @"alphaBackgroundYaxis"         : @0.0,
                     
                     // Animation
                     @"animationGraphStyle"          : @(BEMLineAnimationDraw)
                  }
             };
}

@end

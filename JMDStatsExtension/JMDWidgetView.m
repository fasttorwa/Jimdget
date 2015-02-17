//
//  JMDWidgetView.m
//  Jimdget
//
//  Created by Marius on 15/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "JMDWidgetView.h"

#import "JMDGraphStyler.h"


@interface JMDWidgetView ()

@property BEMSimpleLineGraphView *hitsGraphView;
@property BEMSimpleLineGraphView *visitsGraphView;
@property (copy) NSArray *hitsGraphConstraints;
@property (copy) NSArray *visitsGraphConstraints;
@property UITapGestureRecognizer *tapRecognizer;
@property (assign) BOOL bothGraphsVisible;

@end


@implementation JMDWidgetView

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self setup];

    [self reload];
}


- (void)setup
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(recognizedTap)];
    [self addGestureRecognizer: self.tapRecognizer];
    self.bothGraphsVisible = YES;
}


- (void)reload
{
    [self layoutSelf];
    [self layoutHitsGraphView];
    [self layoutVisitsGraphView];
}


- (void)layoutSelf
{
    [self.superview addConstraints: @[[NSLayoutConstraint constraintWithItem: self
                                                                   attribute: NSLayoutAttributeTop
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: self.superview
                                                                   attribute: NSLayoutAttributeTop
                                                                  multiplier: 1.0
                                                                    constant: 0.0],
                                      
                                      [NSLayoutConstraint constraintWithItem: self
                                                                   attribute: NSLayoutAttributeLeft
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: self.superview
                                                                   attribute: NSLayoutAttributeLeft
                                                                  multiplier: 1.0
                                                                    constant: 10.0],
                                      
                                      [NSLayoutConstraint constraintWithItem: self
                                                                   attribute: NSLayoutAttributeBottom
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: self.superview
                                                                   attribute: NSLayoutAttributeBottom
                                                                  multiplier: 1.0
                                                                    constant: 0.0],
                                      
                                      [NSLayoutConstraint constraintWithItem: self
                                                                   attribute: NSLayoutAttributeRight
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: self.superview
                                                                   attribute: NSLayoutAttributeRight
                                                                  multiplier: 1.0
                                                                    constant: -10.0]
                                      ]
     ];
}


- (void)layoutHitsGraphView
{
    [self.hitsGraphView removeFromSuperview];
    self.hitsGraphView = [[BEMSimpleLineGraphView alloc] initWithFrame: CGRectZero];
    self.hitsGraphView.delegate = self.hitsGraphDataProvider;
    self.hitsGraphView.dataSource = self.hitsGraphDataProvider;
    
    [JMDGraphStyler styledGraph: self.hitsGraphView withStyle: GraphStyleHits];
    
    self.hitsGraphView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.hitsGraphView];
    
    UIEdgeInsets insets = [self hitsGraphMiniEdgeInsets];
    self.hitsGraphConstraints = @[ [NSLayoutConstraint constraintWithItem: self.hitsGraphView
                                                                attribute: NSLayoutAttributeTop
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: self
                                                                attribute: NSLayoutAttributeTop
                                                               multiplier: 1.0
                                                                 constant: insets.top],
                                   
                                   [NSLayoutConstraint constraintWithItem: self.hitsGraphView
                                                                attribute: NSLayoutAttributeLeft
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: self
                                                                attribute: NSLayoutAttributeLeft
                                                               multiplier: 1.0
                                                                 constant: insets.left],
                                   
                                   [NSLayoutConstraint constraintWithItem: self.hitsGraphView
                                                                attribute: NSLayoutAttributeBottom
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: self
                                                                attribute: NSLayoutAttributeBottom
                                                               multiplier: 1.0
                                                                 constant: insets.bottom],
                                   
                                   [NSLayoutConstraint constraintWithItem: self.hitsGraphView
                                                                attribute: NSLayoutAttributeRight
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: self
                                                                attribute: NSLayoutAttributeRight
                                                               multiplier: 1.0
                                                                 constant: insets.right]
                                   
                                   ];
    [self addConstraints: self.hitsGraphConstraints];

}


- (void)layoutVisitsGraphView
{
    [self.visitsGraphView removeFromSuperview];
    self.visitsGraphView = [[BEMSimpleLineGraphView alloc] initWithFrame: CGRectZero];
    self.visitsGraphView.delegate = self.visitsGraphDataProvider;
    self.visitsGraphView.dataSource = self.visitsGraphDataProvider;
    
    [JMDGraphStyler styledGraph: self.visitsGraphView withStyle: GraphStyleVisits];
    
    self.visitsGraphView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.visitsGraphView];
    
    UIEdgeInsets insets = [self visitsGraphMiniEdgeInsets];
    self.visitsGraphConstraints = @[ [NSLayoutConstraint constraintWithItem: self.visitsGraphView
                                                                  attribute: NSLayoutAttributeTop
                                                                  relatedBy: NSLayoutRelationEqual
                                                                     toItem: self
                                                                  attribute: NSLayoutAttributeTop
                                                                 multiplier: 1.0
                                                                   constant: insets.top],
                                     
                                     [NSLayoutConstraint constraintWithItem: self.visitsGraphView
                                                                  attribute: NSLayoutAttributeLeft
                                                                  relatedBy: NSLayoutRelationEqual
                                                                     toItem: self
                                                                  attribute: NSLayoutAttributeLeft
                                                                 multiplier: 1.0
                                                                   constant: insets.left],
                                     
                                     [NSLayoutConstraint constraintWithItem: self.visitsGraphView
                                                                  attribute: NSLayoutAttributeBottom
                                                                  relatedBy: NSLayoutRelationEqual
                                                                     toItem: self
                                                                  attribute: NSLayoutAttributeBottom
                                                                 multiplier: 1.0
                                                                   constant: insets.bottom],
                                     
                                     [NSLayoutConstraint constraintWithItem: self.visitsGraphView
                                                                  attribute: NSLayoutAttributeRight
                                                                  relatedBy: NSLayoutRelationEqual
                                                                     toItem: self
                                                                  attribute: NSLayoutAttributeRight
                                                                 multiplier: 1.0
                                                                   constant: insets.right]
                                     
                                     ];
    [self addConstraints: self.visitsGraphConstraints];
}


# pragma mark - Dynamics

- (void)showBothGraphs
{
    self.bothGraphsVisible = YES;
    self.visitsGraphView.hidden = NO;
    self.hitsGraphView.hidden = NO;
    
    [self applyInsets: [self visitsGraphMiniEdgeInsets] toGraphConstraints: self.visitsGraphConstraints];
    [self applyInsets: [self hitsGraphMiniEdgeInsets] toGraphConstraints: self.hitsGraphConstraints];
    [self layoutIfNeeded];
}


- (void)showFullGraph: (BEMSimpleLineGraphView *)graphView
{
    self.bothGraphsVisible = NO;
    self.visitsGraphView.hidden = (graphView == self.visitsGraphView) ?  NO : YES;
    self.hitsGraphView.hidden = !self.visitsGraphView.hidden;
    
    [self applyInsets: [self graphFullInsets] toGraphConstraints: self.hitsGraphConstraints];
    [self applyInsets: [self graphFullInsets] toGraphConstraints: self.visitsGraphConstraints];
    [self layoutIfNeeded];
}


- (void)applyInsets: (UIEdgeInsets)insets toGraphConstraints: (NSArray *)graphConstraints
{
    ((NSLayoutConstraint *)graphConstraints[0]).constant = insets.top;
    ((NSLayoutConstraint *)graphConstraints[1]).constant = insets.left;
    ((NSLayoutConstraint *)graphConstraints[2]).constant = insets.bottom;
    ((NSLayoutConstraint *)graphConstraints[3]).constant = insets.right;
}


# pragma mark - Insets

- (UIEdgeInsets)visitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, 5, -40, -([UIScreen mainScreen].bounds.size.width / 2) - 10);
}


- (UIEdgeInsets)hitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, ([UIScreen mainScreen].bounds.size.width / 2) + 10, -40, -5);
}


- (UIEdgeInsets)graphFullInsets
{
    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}


# pragma mark - Tap Recognition

- (void)recognizedTap
{
    CGPoint location = [self.tapRecognizer locationInView: self];
    
    if (self.bothGraphsVisible)
    {
        if (location.x < [UIScreen mainScreen].bounds.size.width / 2)
        {
            [self showFullGraph: self.visitsGraphView];
        }
        else
        {
            [self showFullGraph: self.hitsGraphView];
        }
    }
    else
    {
        [self showBothGraphs];
    }
}


# pragma mark - Accessors

- (void)setHitsGraphDataProvider:(id<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource>)hitsGraphDataProvider
{
    _hitsGraphDataProvider = hitsGraphDataProvider;
    [self setNeedsDisplay];
}


- (void)setVisitsGraphDataProvider:(id<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource>)visitsGraphDataProvider
{
    _visitsGraphDataProvider = visitsGraphDataProvider;
    [self setNeedsDisplay];
}



@end

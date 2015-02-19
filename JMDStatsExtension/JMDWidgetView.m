//
//  JMDWidgetView.m
//  Jimdget
//
//  Created by Marius on 15/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "JMDWidgetView.h"

#import "View+MASAdditions.h"
#import "View+MASShorthandAdditions.h"
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
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(recognizedTap)];
    [self addGestureRecognizer: self.tapRecognizer];
    self.bothGraphsVisible = YES;
}


- (void)reload
{
    if (self.superview) // to prevent from reloading when notification center is being closed
    {
        [self layoutSelf];
        [self layoutHitsGraphView];
        [self layoutVisitsGraphView];
    }
}


- (void)layoutSelf
{
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 10, 0, 10);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).with.insets(padding);
    }];
}


- (void)layoutHitsGraphView
{
    if (!self.hitsGraphView)
    {
        self.hitsGraphView = [[BEMSimpleLineGraphView alloc] initWithFrame: CGRectZero];
        self.hitsGraphView.delegate = self.hitsGraphDataProvider;
        self.hitsGraphView.dataSource = self.hitsGraphDataProvider;
        [self addSubview: self.hitsGraphView];
        
        UIEdgeInsets padding = [self wrapped_hitsGraphMiniEdgeInsets];
        [self.hitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(padding);
        }];
    }
    
    [JMDGraphStyler styledGraph: self.hitsGraphView withStyle: GraphStyleHits];
}


- (void)layoutVisitsGraphView
{
    if (!self.visitsGraphView)
    {
        self.visitsGraphView = [[BEMSimpleLineGraphView alloc] initWithFrame: CGRectZero];
        self.visitsGraphView.delegate = self.visitsGraphDataProvider;
        self.visitsGraphView.dataSource = self.visitsGraphDataProvider;
        [self addSubview: self.visitsGraphView];
        
        UIEdgeInsets padding = [self wrapped_visitsGraphMiniEdgeInsets];
        [self.visitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(padding);
        }];
    }
    
    [JMDGraphStyler styledGraph: self.visitsGraphView withStyle: GraphStyleVisits];
}


# pragma mark - Dynamics

- (void)wrapped_showBothGraphs
{
    self.bothGraphsVisible = YES;
    self.visitsGraphView.hidden = NO;
    self.hitsGraphView.hidden = NO;
    
    UIEdgeInsets hitsPadding = [self wrapped_hitsGraphMiniEdgeInsets];
    [self.hitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(hitsPadding);
    }];
    
    UIEdgeInsets visitsPadding = [self wrapped_visitsGraphMiniEdgeInsets];
    [self.visitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(visitsPadding);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}


- (void)wrapped_showFullGraph: (BEMSimpleLineGraphView *)graphView
{
    self.bothGraphsVisible = NO;
    self.visitsGraphView.hidden = !(graphView == self.visitsGraphView);
    self.hitsGraphView.hidden = !self.visitsGraphView.hidden;
    
    UIEdgeInsets padding = [self wrapped_graphFullInsets];
    [graphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
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

- (UIEdgeInsets)wrapped_visitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, 5, 40, +([UIScreen mainScreen].bounds.size.width / 2) + 10);
}


- (UIEdgeInsets)wrapped_hitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, ([UIScreen mainScreen].bounds.size.width / 2) + 10, 40, 5);
}


- (UIEdgeInsets)wrapped_graphFullInsets
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
            [self wrapped_showFullGraph: self.visitsGraphView];
        }
        else
        {
            [self wrapped_showFullGraph: self.hitsGraphView];
        }
    }
    else
    {
        [self wrapped_showBothGraphs];
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

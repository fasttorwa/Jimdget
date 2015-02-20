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

@property UITapGestureRecognizer *tapRecognizer;
@property BEMSimpleLineGraphView *visitsGraphView;
@property BEMSimpleLineGraphView *hitsGraphView;
@property UILabel *visitsGraphLabel;
@property UILabel *hitsGraphLabel;
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
    
    self.visitsGraphView = [BEMSimpleLineGraphView new];
    [self addSubview: self.visitsGraphView];
    
    self.hitsGraphView = [BEMSimpleLineGraphView new];
    [self addSubview: self.hitsGraphView];
    
    self.visitsGraphLabel = [UILabel new];
    self.visitsGraphLabel.text          = NSLocalizedString(@"JMDWidgetView.visitsLabel.text", NULL);
    self.visitsGraphLabel.textAlignment = NSTextAlignmentRight;
    self.visitsGraphLabel.font          = [UIFont fontWithName: @"HelveticaNeue-Light" size: 14];
    self.visitsGraphLabel.textColor     = [UIColor whiteColor];
    [self addSubview: self.visitsGraphLabel];
    
    self.hitsGraphLabel = [UILabel new];
    self.hitsGraphLabel.text            = NSLocalizedString(@"JMDWidgetView.hitsLabel.text", NULL);
    self.hitsGraphLabel.textAlignment   = NSTextAlignmentRight;
    self.hitsGraphLabel.font            = [UIFont fontWithName: @"HelveticaNeue-Light" size: 14];
    self.hitsGraphLabel.textColor       = [UIColor whiteColor];
    [self addSubview: self.hitsGraphLabel];
}


- (void)reload
{
    if (self.superview) // prevent from reloading if view is not part of view hierarchy (e.g. when notification center is being closed)
    {
        [self layoutSelf];
        [self layoutVisitsGraphView];
        [self layoutHitsGraphView];
    }
}


- (void)layoutSelf
{
    UIEdgeInsets padding = [self selfEdgeInsets];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).with.insets(padding);
    }];
}


- (void)layoutVisitsGraphView
{
    self.visitsGraphView.delegate = self.visitsGraphDataProvider;
    self.visitsGraphView.dataSource = self.visitsGraphDataProvider;
    
    UIEdgeInsets padding = [self visitsGraphMiniEdgeInsets];
    [self.visitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];

    [self.visitsGraphLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.visitsGraphView.mas_width).with.multipliedBy(0.3);
        make.height.equalTo(self.visitsGraphView.mas_height).with.multipliedBy(0.1);
        make.top.equalTo(self.visitsGraphView.mas_top);
        make.right.equalTo(self.visitsGraphView.mas_right);
    }];
    
    [JMDGraphStyler styledGraph: self.visitsGraphView withStyle: GraphStyleVisits];
}


- (void)layoutHitsGraphView
{
    self.hitsGraphView.delegate = self.hitsGraphDataProvider;
    self.hitsGraphView.dataSource = self.hitsGraphDataProvider;
    
    UIEdgeInsets padding = [self hitsGraphMiniEdgeInsets];
    [self.hitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];
    
    [self.hitsGraphLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.hitsGraphView.mas_width).with.multipliedBy(0.3);
        make.height.equalTo(self.hitsGraphView.mas_height).with.multipliedBy(0.1);
        make.top.equalTo(self.hitsGraphView.mas_top);
        make.right.equalTo(self.hitsGraphView.mas_right);
    }];
    
    [JMDGraphStyler styledGraph: self.hitsGraphView withStyle: GraphStyleHits];
}


# pragma mark - Dynamics

- (void)showBothGraphs
{
    self.bothGraphsVisible          = YES;
    self.visitsGraphView.hidden     = NO;
    self.hitsGraphView.hidden       = NO;
    self.visitsGraphLabel.hidden    = NO;
    self.hitsGraphLabel.hidden      = NO;
    
    UIEdgeInsets hitsPadding = [self hitsGraphMiniEdgeInsets];
    [self.hitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(hitsPadding);
    }];
    
    UIEdgeInsets visitsPadding = [self visitsGraphMiniEdgeInsets];
    [self.visitsGraphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(visitsPadding);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}


- (void)showFullGraph: (BEMSimpleLineGraphView *)graphView
{
    self.bothGraphsVisible          = NO;
    self.visitsGraphView.hidden     = !(graphView == self.visitsGraphView);
    self.hitsGraphView.hidden       = !self.visitsGraphView.hidden;
    self.visitsGraphLabel.hidden    = self.visitsGraphView.hidden;
    self.hitsGraphLabel.hidden      = self.hitsGraphView.hidden;
    
    UIEdgeInsets padding = [self graphFullInsets];
    [graphView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}


# pragma mark - Insets

- (UIEdgeInsets)selfEdgeInsets
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (UIEdgeInsets)visitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, 5, 40, +([UIScreen mainScreen].bounds.size.width / 2) + 10);
}


- (UIEdgeInsets)hitsGraphMiniEdgeInsets
{
    return UIEdgeInsetsMake(40, ([UIScreen mainScreen].bounds.size.width / 2) + 10, 40, 5);
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
    [self reload];
}


- (void)setVisitsGraphDataProvider:(id<BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource>)visitsGraphDataProvider
{
    _visitsGraphDataProvider = visitsGraphDataProvider;
    [self reload];
}



@end

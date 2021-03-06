//
//  TodayViewController.m
//  JMDStatsExtension
//
//  Created by Marius on 13/02/15.
//  Copyright (c) 2015 Bonsai Industries. All rights reserved.
//

#import "TodayViewController.h"

#import "Const.h"
#import <NotificationCenter/NotificationCenter.h>
#import "JMDUserDefaultsManager.h"
#import "JMDWidgetView.h"
#import "JMDGraphDataProvider.h"


@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
@property JMDGraphDataProvider *hitsGraphDataProvider;
@property JMDGraphDataProvider *visitsGraphDataProvider;
@property JMDWidgetView *widgetView;

@end


@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hitsGraphDataProvider = [JMDGraphDataProvider new];
    self.visitsGraphDataProvider = [JMDGraphDataProvider new];
    
    
    NSArray *keys = [JMDUserDefaultsManager objectForKey: kKeysKey fromStore: UserDefaultsStoreAppGroup];
    
    if (keys.count == 2)
    {
        self.noDataLabel.hidden = YES;
        
        self.widgetView = [JMDWidgetView new];
        self.hitsGraphDataProvider.pointValues = [JMDUserDefaultsManager objectForKey: keys[0] fromStore: UserDefaultsStoreAppGroup];
        self.visitsGraphDataProvider.pointValues = [JMDUserDefaultsManager objectForKey: keys[1] fromStore: UserDefaultsStoreAppGroup];
        self.widgetView.hitsGraphDataProvider = self.hitsGraphDataProvider;
        self.widgetView.visitsGraphDataProvider = self.visitsGraphDataProvider;
        [self.view addSubview: self.widgetView];
    }
    else
    {
        NSLog(@"No data found in the store. Run Jimdget to generate new data.");
    }
}


- (CGSize)preferredContentSize
{
    return CGSizeMake(0, 200); // <- determins height of Today Extension
}


# pragma mark - NCWidgetProviding

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    completionHandler(NCUpdateResultNewData);
}


- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
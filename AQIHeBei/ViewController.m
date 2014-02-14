//
//  ViewController.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "ViewController.h"
#import "HHDataManager.h"
#import "HHCityView.h"
#import "Toast+UIView.h"

#import "CityDetailViewController.h"

#define kDefaultTitleFontSize       18
#define kDefaultViewMargin          5
#define kDefaultTitleViewHeight     100
#define kDefaultViewHeight          80

@interface ViewController ()<UIScrollViewDelegate, HHAQICityViewDelegate>
{
    UILabel *_labelForTitle;
    NSMutableArray *_cityViewArray;
    
    UIScrollView *_backScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

    _backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _backScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backScrollView.delegate = self;
    _backScrollView.scrollEnabled = YES;
    _backScrollView.backgroundColor = [UIColor clearColor];
    _backScrollView.showsVerticalScrollIndicator = YES;
    _backScrollView.showsHorizontalScrollIndicator = NO;
    
    _backScrollView.contentSize = self.view.bounds.size;
    
    [self.view addSubview:_backScrollView];
    
    
    [self initUI];
    
    [self updateAQIDataFromServer:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateAction
{
    [self updateAQIDataFromServer:YES];
}

#pragma mark - 

- (void)initUI
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultViewMargin, kDefaultViewMargin, self.view.bounds.size.width - kDefaultViewMargin * 2, kDefaultTitleViewHeight)];
    
    titleView.backgroundColor = [UIColor colorWithRed:0.1 green:0.9 blue:0.6 alpha:1.0];
    
    _labelForTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultViewMargin, kDefaultViewMargin, titleView.bounds.size.width - kDefaultViewMargin * 2, titleView.bounds.size.height - kDefaultViewMargin * 2)];
    
    _labelForTitle.textAlignment = NSTextAlignmentJustified;
    _labelForTitle.numberOfLines = 3;
    _labelForTitle.font = [UIFont boldSystemFontOfSize:kDefaultTitleFontSize];
    
    _labelForTitle.textColor = [UIColor whiteColor];
    
    [titleView addSubview:_labelForTitle];
    
    [_backScrollView addSubview:titleView];
}

- (void)updateUIWithCityAggregate:(HHAQICityAggregate *)AQICityAggregate
{
    
    if (AQICityAggregate == nil)
    {
        return;
    }
    
    _labelForTitle.text = AQICityAggregate.title;
    
    if (_cityViewArray != nil)
    {
        for (HHCityView *cityView in _cityViewArray)
        {
            cityView.delegate = nil;
            [cityView removeFromSuperview];
        }
        
        [_cityViewArray removeAllObjects];
        _cityViewArray = nil;
    }
    
    
    _cityViewArray = [NSMutableArray array];
    
    double startY = kDefaultTitleViewHeight + kDefaultViewMargin * 2;
    double width = (self.view.bounds.size.width - kDefaultViewMargin * 3) / 2.0;
    double height = kDefaultViewHeight;
    
    int index = 0;
    
    for (HHAQICity *city in AQICityAggregate.cities)
    {
        CGRect frame = CGRectMake(kDefaultViewMargin + (kDefaultViewMargin + width) * (index % 2), startY + (kDefaultViewMargin + height) * (index / 2), width, height);
        HHCityView *view = [[HHCityView alloc] initWithFrame:frame city:city];
        view.delegate = self;
        
        [_cityViewArray addObject:view];
        [_backScrollView addSubview:view];
        
        ++index;
    }
    
    double rowNum = ceil((double)index / 2.0);
    double sizeHeight = startY + (height + kDefaultViewMargin) * rowNum;
    _backScrollView.contentSize = CGSizeMake(_backScrollView.contentSize.width, sizeHeight);
  
}

- (void)updateAQIDataFromServer:(BOOL)fromServer
{
    if ([[HHDataManager sharedManager] isUpdating])
    {
        [self.view makeToast:@"更新中..." duration:1.0 position:@"center"];
        return;
    }
    
    self.title = @"更新中...";
    
    [[HHDataManager sharedManager] updateDataForceFromServer:fromServer withHandler:^(HHAQICityAggregate *AQICityAggregate, NSError *error) {
        if (error)
        {
            NSLog(@"error :%@", error);
        }
        else
        {
            NSLog(@"AQICityAggregate :%@", AQICityAggregate);
            
            self.title = [NSString stringWithFormat:@"%@ 空气质量监控", AQICityAggregate.region];
            [self updateUIWithCityAggregate:AQICityAggregate];
            
            [self.view makeToast:@"更新成功!" duration:1.0 position:@"center"];
            
            [_backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
}

- (void)didAQICityViewTouched:(HHCityView *)cityView
{
    CityDetailViewController *controller = [[CityDetailViewController alloc] init];
    controller.city = cityView.city;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end

//
//  HHCityView.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-13.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHAQICity;
@protocol HHAQICityViewDelegate;

@interface HHCityView : UIView

@property (nonatomic, assign) id<HHAQICityViewDelegate> delegate;
@property (nonatomic, strong) HHAQICity *city;

- (id)initWithFrame:(CGRect)frame city:(HHAQICity *)city;

- (void)updateUI;

@end


@protocol HHAQICityViewDelegate <NSObject>

- (void)didAQICityViewTouched:(HHCityView *)cityView;

@end





//
//  HHCityView.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-13.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHCityView.h"
#import "HHAQICity.h"
#import "UIColor+Extension.h"

#define kLabelMargin        10
#define kLabelHeigth        20

#define kDefaultFontSize        20
#define kDefaultInfoFontSize    15

@implementation HHCityView
{
    UILabel *_name;
    UILabel *_level;
    UILabel *_AQI;
}

@synthesize city = _city;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame city:(HHAQICity *)city
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.city = city;
        
        [self updateUI];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap
{
	if (_delegate && [_delegate respondsToSelector:@selector(didAQICityViewTouched:)])
    {
        [_delegate didAQICityViewTouched:self];
    }
}


- (void)setCity:(HHAQICity *)city
{
    if (city == nil || self.city == city)
    {
        return;
    }
    
    _city = city;
    
    [self updateUI];
}

- (void)updateUI
{
    if (!self.city)
    {
        self.backgroundColor = [UIColor grayColor];
        return;
    }
    
    self.backgroundColor = [UIColor colorWithHexString:self.city.color];
    
    double labelWidth = self.frame.size.width - kLabelMargin * 2;
    
    if (_name == nil)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(kLabelMargin, kLabelMargin, labelWidth, kLabelHeigth)];
        _name.font = [UIFont boldSystemFontOfSize:kDefaultFontSize];
        _name.textColor = [UIColor blackColor];
        _name.text = @"...";
        
        [self addSubview:_name];

    }
    _name.text = self.city.name;
    
    
    //
    if (_AQI == nil)
    {
        _AQI = [[UILabel alloc] initWithFrame:CGRectMake(kLabelMargin, kLabelMargin * 2 + kLabelHeigth, labelWidth, kLabelHeigth)];
        _AQI.font = [UIFont systemFontOfSize:kDefaultInfoFontSize];
        _AQI.textColor = [UIColor blackColor];
        _AQI.text = @"...";
        
        [self addSubview:_AQI];
    }
    
    _AQI.text = [NSString stringWithFormat:@"AQI:%@", self.city.AQI];
    
    //
    if (_level == nil)
    {
        _level = [[UILabel alloc] initWithFrame:CGRectMake(kLabelMargin, (kLabelMargin + kLabelHeigth) * 2, labelWidth, kLabelHeigth)];
        _level.font = [UIFont systemFontOfSize:kDefaultInfoFontSize];
        _level.textColor = [UIColor blackColor];
        _level.text = @"...";
        
        [self addSubview:_level];
    }
    
    _level.text = [NSString stringWithFormat:@"Level:%@", self.city.level];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end



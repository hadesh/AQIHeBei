//
//  HHAQIPointer.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAQIPointer : NSObject<NSCoding>

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *AQI;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *maxPoll;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *tips;

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

@property (nonatomic, strong) NSArray *polls;

@end

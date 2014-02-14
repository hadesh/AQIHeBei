//
//  HHAQICity.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHAQIPointer.h"
#import "HHAQIPollObject.h"

@interface HHAQICity : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *AQI;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *maxPoll;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *tips;

@property (nonatomic, strong) NSArray *polls;
@property (nonatomic, strong) NSArray *pointers;

@end

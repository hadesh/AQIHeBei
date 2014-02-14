//
//  HHDataManager.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHAQICityAggregate.h"
#import "HHAQICity.h"
#import "HHAQIPollObject.h"
#import "HHAQIPointer.h"

@interface HHDataManager : NSObject

@property (nonatomic, readonly) BOOL isUpdating;
@property (nonatomic, readonly) HHAQICityAggregate *AQICityAggregate;

+ (HHDataManager *)sharedManager;

- (void)updateDataForceFromServer:(BOOL)updateFromServer withHandler:(void (^)(HHAQICityAggregate *AQICityAggregate, NSError *error))handler;

@end
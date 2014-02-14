//
//  HHAQICityAggregate.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAQICityAggregate : NSObject<NSCoding>

- (id)initWithTitle:(NSString *)title
             region:(NSString *)region
       organization:(NSString *)organization
         updateDate:(NSDate *)updateDate
             cities:(NSArray *)cities;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *publicOrganization;
@property (nonatomic, copy) NSDate *updateDate;
@property (nonatomic, strong) NSArray *cities;

@end

@interface HHAQICityAggregate (FileSystem)

+ (id)cityAggregateWithContentsOfFile:(NSString *)path;

- (BOOL)writeToFile:(NSString *)path;

@end


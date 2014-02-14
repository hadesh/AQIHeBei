//
//  HHXMLDataParser.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHAQICityAggregate;

@interface HHXMLDataParser : NSObject

@property (nonatomic, readonly, strong) NSError *error;

@property (nonatomic, readonly, strong) HHAQICityAggregate *cityAggregate;

- (id)initWithXMLData:(NSData *)xmlData;

- (void)parse;

@end

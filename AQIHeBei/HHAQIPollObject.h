//
//  HHAQIPollObject.h
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAQIPollObject : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *IAQI;

@end

//
//  HHAQIPollObject.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHAQIPollObject.h"

#define HHAQIPollKeyForName             @"name"
#define HHAQIPollKeyForValue            @"value"
#define HHAQIPollKeyForCount            @"count"
#define HHAQIPollKeyForIAQI             @"IAQI"


@implementation HHAQIPollObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    HHAQIPollObject *poll = [[HHAQIPollObject alloc] init];
    poll.name       = [aDecoder decodeObjectForKey:HHAQIPollKeyForName];
    poll.value      = [aDecoder decodeObjectForKey:HHAQIPollKeyForValue];
    poll.count      = [aDecoder decodeObjectForKey:HHAQIPollKeyForCount];
    poll.IAQI       = [aDecoder decodeObjectForKey:HHAQIPollKeyForIAQI];
    
    return poll;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name      forKey:HHAQIPollKeyForName];
    [aCoder encodeObject:self.value     forKey:HHAQIPollKeyForValue];
    [aCoder encodeObject:self.count     forKey:HHAQIPollKeyForCount];
    [aCoder encodeObject:self.IAQI      forKey:HHAQIPollKeyForIAQI];
}
@end

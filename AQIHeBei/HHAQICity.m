//
//  HHAQICity.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHAQICity.h"

#define HHAQICityKeyForName             @"name"
#define HHAQICityKeyForAQI              @"AQI"
#define HHAQICityKeyForLevel            @"level"
#define HHAQICityKeyForMaxPoll          @"maxPoll"
#define HHAQICityKeyForColor            @"color"
#define HHAQICityKeyForIntro            @"intro"
#define HHAQICityKeyForTips             @"tips"
#define HHAQICityKeyForPolls            @"polls"
#define HHAQICityKeyForPointers         @"pointers"

@implementation HHAQICity

- (id)initWithCoder:(NSCoder *)aDecoder
{
    HHAQICity *city = [[HHAQICity alloc] init];
    city.name       = [aDecoder decodeObjectForKey:HHAQICityKeyForName];
    city.AQI        = [aDecoder decodeObjectForKey:HHAQICityKeyForAQI];
    city.level      = [aDecoder decodeObjectForKey:HHAQICityKeyForLevel];
    city.maxPoll    = [aDecoder decodeObjectForKey:HHAQICityKeyForMaxPoll];
    city.color      = [aDecoder decodeObjectForKey:HHAQICityKeyForColor];
    city.intro      = [aDecoder decodeObjectForKey:HHAQICityKeyForIntro];
    city.tips       = [aDecoder decodeObjectForKey:HHAQICityKeyForTips];
    city.polls      = [aDecoder decodeObjectForKey:HHAQICityKeyForPolls];
    city.pointers   = [aDecoder decodeObjectForKey:HHAQICityKeyForPointers];
    
    return city;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name          forKey:HHAQICityKeyForName];
    [aCoder encodeObject:self.AQI           forKey:HHAQICityKeyForAQI];
    [aCoder encodeObject:self.level         forKey:HHAQICityKeyForLevel];
    [aCoder encodeObject:self.maxPoll       forKey:HHAQICityKeyForMaxPoll];
    [aCoder encodeObject:self.color         forKey:HHAQICityKeyForColor];
    [aCoder encodeObject:self.intro         forKey:HHAQICityKeyForIntro];
    [aCoder encodeObject:self.tips          forKey:HHAQICityKeyForTips];
    [aCoder encodeObject:self.polls         forKey:HHAQICityKeyForPolls];
    [aCoder encodeObject:self.pointers      forKey:HHAQICityKeyForPointers];
}

@end

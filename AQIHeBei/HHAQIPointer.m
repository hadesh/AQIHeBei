//
//  HHAQIPointer.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHAQIPointer.h"

#define HHAQIPointerKeyForCity          @"city"
#define HHAQIPointerKeyForRegion        @"region"
#define HHAQIPointerKeyForName          @"name"
#define HHAQIPointerKeyForAQI           @"AQI"
#define HHAQIPointerKeyForLevel         @"level"
#define HHAQIPointerKeyForMaxPoll       @"maxPoll"
#define HHAQIPointerKeyForColor         @"color"
#define HHAQIPointerKeyForIntro         @"intro"
#define HHAQIPointerKeyForTips          @"tips"
#define HHAQIPointerKeyForLong          @"longitude"
#define HHAQIPointerKeyForLat           @"latitude"
#define HHAQIPointerKeyForPolls         @"pointers"

@implementation HHAQIPointer

- (id)initWithCoder:(NSCoder *)aDecoder
{
    HHAQIPointer *pointer = [[HHAQIPointer alloc] init];
    
    pointer.city       = [aDecoder decodeObjectForKey:HHAQIPointerKeyForCity];
    pointer.region     = [aDecoder decodeObjectForKey:HHAQIPointerKeyForRegion];
    pointer.name       = [aDecoder decodeObjectForKey:HHAQIPointerKeyForName];
    pointer.AQI        = [aDecoder decodeObjectForKey:HHAQIPointerKeyForAQI];
    pointer.level      = [aDecoder decodeObjectForKey:HHAQIPointerKeyForLevel];
    pointer.maxPoll    = [aDecoder decodeObjectForKey:HHAQIPointerKeyForMaxPoll];
    pointer.color      = [aDecoder decodeObjectForKey:HHAQIPointerKeyForColor];
    pointer.intro      = [aDecoder decodeObjectForKey:HHAQIPointerKeyForIntro];
    pointer.tips       = [aDecoder decodeObjectForKey:HHAQIPointerKeyForTips];
    pointer.polls      = [aDecoder decodeObjectForKey:HHAQIPointerKeyForPolls];
    
    return pointer;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.city          forKey:HHAQIPointerKeyForCity];
    [aCoder encodeObject:self.region        forKey:HHAQIPointerKeyForRegion];
    [aCoder encodeObject:self.name          forKey:HHAQIPointerKeyForName];
    [aCoder encodeObject:self.AQI           forKey:HHAQIPointerKeyForAQI];
    [aCoder encodeObject:self.level         forKey:HHAQIPointerKeyForLevel];
    [aCoder encodeObject:self.maxPoll       forKey:HHAQIPointerKeyForMaxPoll];
    [aCoder encodeObject:self.color         forKey:HHAQIPointerKeyForColor];
    [aCoder encodeObject:self.intro         forKey:HHAQIPointerKeyForIntro];
    [aCoder encodeObject:self.tips          forKey:HHAQIPointerKeyForTips];
    [aCoder encodeObject:self.polls         forKey:HHAQIPointerKeyForPolls];
}

@end

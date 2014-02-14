//
//  HHAQICityAggregate.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHAQICityAggregate.h"

#define HHAQICityAggregateKeyForTitle           @"title"
#define HHAQICityAggregateKeyForRegion          @"region"
#define HHAQICityAggregateKeyForOrganization    @"organization"
#define HHAQICityAggregateKeyForDate            @"updateDate"
#define HHAQICityAggregateKeyForCities          @"cities"

@implementation HHAQICityAggregate
@synthesize title = _title;
@synthesize region = _region;
@synthesize publicOrganization = _publicOrganization;
@synthesize updateDate = _updateDate;
@synthesize cities = _cities;

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithTitle:[aDecoder decodeObjectForKey:HHAQICityAggregateKeyForTitle]
                        region:[aDecoder decodeObjectForKey:HHAQICityAggregateKeyForRegion]
                  organization:[aDecoder decodeObjectForKey:HHAQICityAggregateKeyForOrganization]
                    updateDate:[aDecoder decodeObjectForKey:HHAQICityAggregateKeyForDate]
                        cities:[aDecoder decodeObjectForKey:HHAQICityAggregateKeyForCities]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:HHAQICityAggregateKeyForTitle];
    [aCoder encodeObject:self.region forKey:HHAQICityAggregateKeyForRegion];
    [aCoder encodeObject:self.publicOrganization forKey:HHAQICityAggregateKeyForOrganization];
    [aCoder encodeObject:self.updateDate forKey:HHAQICityAggregateKeyForDate];
    [aCoder encodeObject:self.cities   forKey:HHAQICityAggregateKeyForCities];
}

#pragma mark -

- (id)initWithTitle:(NSString *)title
             region:(NSString *)region
       organization:(NSString *)organization
         updateDate:(NSDate *)updateDate
             cities:(NSArray *)cities
{
    if (self = [super init])
    {
        self.title = title;
        self.region = region;
        self.publicOrganization = organization;
        self.updateDate = updateDate;
        self.cities = cities;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"#######\n %@ \n %@ \n %@ \n %@ \n #######", self.region, self.publicOrganization, self.updateDate, self.title];
}

@end

@implementation HHAQICityAggregate (FileSystem)

+ (id)cityAggregateWithContentsOfFile:(NSString *)path
{
    if (path == nil)
    {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (BOOL)writeToFile:(NSString *)path
{
    if (path == nil)
    {
        return NO;
    }
    
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

@end



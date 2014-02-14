//
//  HHDataManager.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHDataManager.h"
#import "HHXMLDataParser.h"

#define kDefaultDataServer      @"http://121.28.49.85:8080/datas/hour/130000.xml"
#define kCityAggregateFile      @"cityAggregate.plist"

@implementation HHDataManager

@synthesize isUpdating = _isUpdating;
@synthesize AQICityAggregate = _AQICityAggregate;

+ (HHDataManager *)sharedManager
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _isUpdating = NO;
        _AQICityAggregate = nil;
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - 

- (void)updateDataForceFromServer:(BOOL)updateFromServer withHandler:(void (^)(HHAQICityAggregate *AQICityAggregate, NSError *error))handler
{
    _isUpdating = YES;
    
    BOOL needsUpdateFromServer = YES;
    
    if (!updateFromServer && [self updateAQIDataFromLocal])
    {
        
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        NSDate *localeDate = [date dateByAddingTimeInterval: interval];
        
        if ([self.AQICityAggregate.updateDate timeIntervalSinceDate:localeDate] > -1.1*60.0*60.0)
        {
            needsUpdateFromServer = NO;
            if (handler != nil)
            {
                handler(self.AQICityAggregate, nil);
            }
            _isUpdating = NO;
        }
    }
    
    if (updateFromServer || needsUpdateFromServer)
    {
        dispatch_async((dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)), ^{
            
            NSError *error = nil;
            
            [self updateAQIData:&error];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (handler != nil)
                {
                    handler(self.AQICityAggregate, error);
                }
            });
            
            _isUpdating = NO;
        });
    }
}

#pragma mark - 

- (NSString *)localFilePath
{
    NSArray *allpaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [allpaths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/%@", cachesDirectory, kCityAggregateFile];
}

- (BOOL)updateAQIDataFromLocal
{
    NSString *filePath = [self localFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        _AQICityAggregate = [HHAQICityAggregate cityAggregateWithContentsOfFile:filePath];
        if (_AQICityAggregate)
        {
            return YES;
        }
    }
    return NO;
}

- (void)updateAQIData:(NSError **)error
{
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kDefaultDataServer]];
    
    HHXMLDataParser *parser = [[HHXMLDataParser alloc] initWithXMLData:xmlData];
    [parser parse];
    
    if (parser.error != nil)
    {
        *error = [[NSError alloc] initWithDomain:parser.error.domain code:parser.error.code userInfo:parser.error.userInfo];
    }
    else
    {
        if (parser.cityAggregate != nil)
        {
            _AQICityAggregate = parser.cityAggregate;
            [_AQICityAggregate writeToFile:[self localFilePath]];
        }
        else
        {
            *error = [NSError errorWithDomain:@"HHDataManagerError"
                                         code:0
                                     userInfo:[NSDictionary dictionaryWithObject:@"cityAggregate is nil" forKey:NSLocalizedDescriptionKey]];
        }
        
    }

}


@end

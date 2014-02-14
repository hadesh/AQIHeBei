//
//  HHXMLDataParser.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-10.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "HHXMLDataParser.h"
#import "HHAQICityAggregate.h"
#import "HHAQICity.h"
#import "HHAQIPointer.h"
#import "HHAQIPollObject.h"

#define kXMLParserKeyForSystem          @"System"
#define kXMLParserKeyForRegion          @"Region"
#define kXMLParserKeyForPublicOrg       @"PublicOrg"
#define kXMLParserKeyForUpdatetime      @"Updatetime"
#define kXMLParserKeyForTitle           @"MapsTitle"

#define kXMLParserKeyForCitys           @"Citys"
#define kXMLParserKeyForPolls           @"Polls"
#define kXMLParserKeyForPointers        @"Pointers"

#define kXMLParserKeyForCity        @"City"
#define kXMLParserKeyForName        @"Name"
#define kXMLParserKeyForAQI         @"AQI"
#define kXMLParserKeyForLevel       @"Level"
#define kXMLParserKeyForMaxPoll     @"MaxPoll"
#define kXMLParserKeyForColor       @"Color"
#define kXMLParserKeyForIntro       @"Intro"
#define kXMLParserKeyForTips        @"Tips"

#define kXMLParserKeyForPoll        @"Poll"
#define kXMLParserKeyForValue       @"Value"
#define kXMLParserKeyForCount       @"Count"
#define kXMLParserKeyForIAQI        @"IAQI"

#define kXMLParserKeyForPointer     @"Pointer"
#define kXMLParserKeyForCLng        @"CLng"
#define kXMLParserKeyForCLat        @"CLat"

#define kXMLParserKeyForImages      @"Images"
#define kXMLParserKeyForImage       @"Image"

@interface HHXMLDataParser () <NSXMLParserDelegate>

@property (nonatomic, readwrite, strong) NSError *error;

@property (nonatomic, readwrite, strong) HHAQICityAggregate *cityAggregate;

@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *pointerArray;
@property (nonatomic, strong) NSMutableArray *pollArray;

/* XML parser. */
@property (nonatomic, strong) NSData *xmlData;
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableString *currentString;

@property (nonatomic, assign) BOOL parsingSystem;
@property (nonatomic, assign) BOOL parsingCity;
@property (nonatomic, assign) BOOL parsingPointer;
@property (nonatomic, assign) BOOL parsingPoll;
@property (nonatomic, assign) BOOL parsingImage;

@property (nonatomic, strong) HHAQICity *currentCity;
@property (nonatomic, strong) HHAQIPointer *currentPointer;
@property (nonatomic, strong) HHAQIPollObject *currentPoll;

@end

@implementation HHXMLDataParser

@synthesize error         = _error;
@synthesize cityAggregate = _cityAggregate;
@synthesize cityArray     = _cityArray;
@synthesize pointerArray  = _pointerArray;
@synthesize pollArray     = _pollArray;

@synthesize xmlData             = _xmlData;
@synthesize parser              = _parser;
@synthesize currentString       = _currentString;
@synthesize parsingImage        = _parsingImage;

@synthesize parsingSystem       = _parsingSystem;
@synthesize parsingCity         = _parsingCity;
@synthesize parsingPointer      = _parsingPointer;
@synthesize parsingPoll         = _parsingPoll;

@synthesize currentCity         = _currentCity;
@synthesize currentPointer      = _currentPointer;
@synthesize currentPoll         = _currentPoll;

#pragma mark - Interfaces

- (void)parse
{
    if (self.xmlData.length == 0)
    {
        self.error = [NSError errorWithDomain:@"XMLCityAggregateErrorDomain"
                                         code:0
                                     userInfo:[NSDictionary dictionaryWithObject:@"xmlData is nil" forKey:NSLocalizedDescriptionKey]];
        
        return;
    }
    
    if (self.parser == nil)
    {
        self.parser = [[NSXMLParser alloc] initWithData:self.xmlData];
        self.parser.delegate = self;
    }
    
    [self.parser parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.cityAggregate = [[HHAQICityAggregate alloc] init];
    self.cityArray = [NSMutableArray array];
    
    self.currentString = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.currentString = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict
{
    self.currentString = nil;
    
    if ([elementName isEqualToString:kXMLParserKeyForSystem])
    {
        self.parsingSystem = YES;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForCity])
    {
        
        if (!self.parsingPointer)
        {
            self.parsingCity = YES;
            self.currentCity = [[HHAQICity alloc] init];
        }
        else // city in pointer node
        {
            
        }
    }
    else if ([elementName isEqualToString:kXMLParserKeyForPoll])
    {
        self.parsingPoll = YES;
        self.currentPoll = [[HHAQIPollObject alloc] init];
    }
    else if ([elementName isEqualToString:kXMLParserKeyForPointer])
    {
        self.parsingPointer = YES;
        self.currentPointer = [[HHAQIPointer alloc] init];
    }
    else if ([elementName isEqualToString:kXMLParserKeyForImages])
    {
        self.parsingImage = YES;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForPointers])
    {
        self.pointerArray = [NSMutableArray array];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:kXMLParserKeyForSystem])
    {
        self.parsingSystem = NO;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForCity])
    {
        if (!self.parsingPointer)
        {
            self.parsingCity = NO;
            
            if (self.currentCity)
            {
                [self.cityArray addObject:self.currentCity];
            }
            
            self.currentCity = nil;
        }
        
    }
    else if ([elementName isEqualToString:kXMLParserKeyForPoll])
    {
        self.parsingPoll = NO;
        if (self.currentPoll)
        {
            [self.pollArray addObject:self.currentPoll];
        }
        self.currentPoll = nil;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForPointer])
    {
        self.parsingPointer = NO;
        if (self.currentPointer)
        {
            [self.pointerArray addObject:self.currentPointer];
        }
        self.currentPointer = nil;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForCitys])
    {
        self.cityAggregate.cities = self.cityArray;
    }
    else if ([elementName isEqualToString:kXMLParserKeyForImages])
    {
        self.parsingImage = NO;
    }
    
    // parse system
    if (self.parsingSystem)
    {
        if ([elementName isEqualToString:kXMLParserKeyForRegion])
        {
            self.cityAggregate.region = self.currentString;
        }
        else if ([elementName isEqualToString:kXMLParserKeyForPublicOrg])
        {
            self.cityAggregate.publicOrganization = self.currentString;
        }
        else if ([elementName isEqualToString:kXMLParserKeyForUpdatetime])
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            
            self.cityAggregate.updateDate = [dateFormatter dateFromString:self.currentString];
        }
        else if ([elementName isEqualToString:kXMLParserKeyForTitle])
        {
            self.cityAggregate.title = self.currentString;
        }
    }
    
    // parse city
    if (self.parsingCity)
    {
        if (self.parsingPoll)
        {
            
        }
        else if (self.parsingImage)
        {
            
        }
        else if (self.parsingPointer)
        {
            if (self.parsingPoll)
            {
                
            }
            else if (self.parsingImage)
            {
                
            }
            else
            {
                if ([elementName isEqualToString:kXMLParserKeyForCity])
                {
                    self.currentPointer.city = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForRegion])
                {
                    self.currentPointer.region = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForName])
                {
                    self.currentPointer.name = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForAQI])
                {
                    self.currentPointer.AQI = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForLevel])
                {
                    self.currentPointer.level = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForMaxPoll])
                {
                    self.currentPointer.maxPoll = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForColor])
                {
                    self.currentPointer.color = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForIntro])
                {
                    self.currentPointer.intro = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForTips])
                {
                    self.currentPointer.tips = self.currentString;
                }
                else if ([elementName isEqualToString:kXMLParserKeyForCLat])
                {
                    self.currentPointer.latitude = [self.currentString doubleValue];
                }
                else if ([elementName isEqualToString:kXMLParserKeyForCLng])
                {
                    self.currentPointer.longitude = [self.currentString doubleValue];
                }

            }
        }
        else
        {
            if ([elementName isEqualToString:kXMLParserKeyForName])
            {
                self.currentCity.name = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForAQI])
            {
                self.currentCity.AQI = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForLevel])
            {
                self.currentCity.level = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForMaxPoll])
            {
                self.currentCity.maxPoll = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForColor])
            {
                self.currentCity.color = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForIntro])
            {
                self.currentCity.intro = self.currentString;
            }
            else if ([elementName isEqualToString:kXMLParserKeyForTips])
            {
                self.currentCity.tips = self.currentString;
            }
            
            else if ([elementName isEqualToString:kXMLParserKeyForPolls])
            {
                // end polls
                if (! self.parsingPointer)
                {
                    
                }
            }
            else if ([elementName isEqualToString:kXMLParserKeyForPointers])
            {
                // end pointers
                self.currentCity.pointers = self.pointerArray;
            }
        }
        
    }
    
    self.currentString = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (string.length == 0)
    {
        return;
    }
    
    if (self.currentString == nil)
    {
        self.currentString = [NSMutableString stringWithString:string];
    }
    else
    {
        [self.currentString appendString:string];
    }

}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.error = parseError;
    self.currentString = nil;
}

#pragma mark - Life Cycle

- (id)initWithXMLData:(NSData *)xmlData
{
    if (self = [super init])
    {
        self.xmlData = xmlData;
    }
    
    return self;
}

@end

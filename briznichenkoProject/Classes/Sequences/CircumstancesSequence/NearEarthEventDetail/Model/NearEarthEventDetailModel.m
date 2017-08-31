//
//  NearEarthEventDetailModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailModel.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataStorageManager.h"
#import "ManagedNearEarthEventEntity.h"

@implementation NearEarthEventDetailModel
{
    NSDictionary *eventDictionary;
}


- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
        [self fetchData];
	}
	return self;
}

-(void) fetchData
{
    self.data = [NSData new];
}

- (void) parseDataFromEventHTML: (void (^) (BOOL finished)) completion
{
    NSString *start;
    NSString *end;
    NSError *error;
    NSString *rawHTML = [NSString stringWithContentsOfURL:self.baseURL
                                                 encoding:NSASCIIStringEncoding
                                                    error:&error];
    if(error)
        NSLog(@"%@", error.localizedDescription);
    start = @"class=\"overlay_host\"";
    end = @"<div class=\"col-xl-2 tallright noprint\">";
    rawHTML = [self stringFromSource:rawHTML betweenStrings:start and:end];
    
    NSMutableDictionary *eventData = [NSMutableDictionary new];
    NSArray *patterns = @[@"(?!<img src=)(\"(.*)\")(?= alt=\")",
                          @"(alt=)(\"(.*)\")(?= title=\")",
                          @"(?!<p class=\"widetitle\" style=\"overflow: hidden;\")(>(.*)<)(?=\\/p>)",
                          @"(?!<img src=)(\"(.*)\")(?=(\n.*)style=)",
                          @"(style=\"margin:5px;\"\\s*alt=\")(.*)\"",
                          @"<table style=\"(.*)table>",
                          @"<p>((.*\\n)*)<\\/p>"];
    NSArray *keys = @[@"event_image",
                      @"event_image_description",
                      @"event_title",
                      @"event_type_icon",
                      @"event_type_description",
                      @"event_date",
                      @"event_description"];
    for(int i = 0; i < patterns.count; i++)
        [eventData setValue:[self regex:patterns[i] fromRawHTML:rawHTML] forKey:keys[i]];
    [eventData setValue:self.baseURL.absoluteString forKey:@"source_url"];
    eventDictionary = [self cleanDictionary:eventData];
    self.eventEntity = [[NearEarthEventEntity alloc] initFromDictionary:eventDictionary];
    
    completion(YES);
}

#pragma mark -- Data processing

- (NSDictionary *) cleanDictionary: (NSMutableDictionary *) dictionaryToClean
{
    NSMutableDictionary *cleanedDict = [NSMutableDictionary dictionaryWithDictionary:dictionaryToClean];
    NSString *cleanedString;
    NSData *imageData;
    NSURL *imageURL;
    
    cleanedString = [cleanedDict valueForKey:@"event_image"];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    imageURL = [NSURL URLWithString:cleanedString];
    NSLog(@"%@", imageURL.absoluteString);
    imageData = [NSData dataWithContentsOfURL:imageURL];
    [cleanedDict setValue:imageData forKey:@"event_image"];
    
    cleanedString = [cleanedDict valueForKey:@"event_image_description"];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"alt=" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    [cleanedDict setValue:cleanedString forKey:@"event_image_description"];
    
    cleanedString = [cleanedDict valueForKey:@"event_type_icon"];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    imageURL = [NSURL URLWithString:cleanedString];
    imageData = [NSData dataWithContentsOfURL:imageURL];
    [cleanedDict setValue:imageData forKey:@"event_type_icon"];
    
    cleanedString = [cleanedDict valueForKey:@"event_type_description"];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"style=margin:5px;\n" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"alt=" withString:@""];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    [cleanedDict setValue:cleanedString forKey:@"event_type_description"];
    
    cleanedString = [self cleanHTMLTags:[cleanedDict valueForKey:@"event_date"]];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [cleanedDict setValue:cleanedString forKey:@"event_date"];
    
    cleanedString = [self cleanHTMLTags:[cleanedDict valueForKey:@"event_description"]];
    cleanedString = [cleanedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [cleanedDict setValue:cleanedString forKey:@"event_description"];
    
    return cleanedDict;
}

#pragma mark -- Data saving

- (void) saveNearEarthEvent: (void (^) (BOOL saved)) completionBlock
{
    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
    ManagedNearEarthEventEntity *eventEntity = [NSEntityDescription insertNewObjectForEntityForName:@"NearEarthEvent" inManagedObjectContext:context];
    
    eventEntity.event_image = self.eventEntity.event_image;
    eventEntity.event_image_description = self.eventEntity.event_image_description;
    eventEntity.event_title = self.eventEntity.event_title;
    eventEntity.event_date = self.eventEntity.event_date;
    eventEntity.event_type_icon = self.eventEntity.event_type_icon;
    eventEntity.event_type_description = self.eventEntity.event_type_description;
    eventEntity.event_description = self.eventEntity.event_description;
    eventEntity.source_url = self.eventEntity.source_url;

    NSError *error = nil;
    if ([context save:&error] == NO)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        completionBlock(NO);
    }
    else
        completionBlock(YES);
}

#pragma mark -- Util

- (NSString *) regex: (NSString *) pattern fromRawHTML: (NSString *)rawHTML
{
    NSString *rawString;
    NSRange stringRange;
    NSArray *replacements = [pattern componentsSeparatedByString:@"(.*)"];
    
    stringRange = [rawHTML rangeOfString:pattern options:NSRegularExpressionSearch];
    if(stringRange.location == NSNotFound)
        return @"None";
    rawString = [rawHTML substringWithRange:stringRange];
    for (NSString *replacement in replacements)
        rawString = [rawString stringByReplacingOccurrencesOfString:replacement withString:@""];
    return rawString;
}

- (NSString *)stringFromSource: (NSString *)source betweenStrings: (NSString *) first and:(NSString *) second
{
    NSRange startRange = [source rangeOfString:first];
    NSRange endRange = [source rangeOfString:second];
    if((startRange.location != NSNotFound) && (endRange.location != NSNotFound))
    {
        NSRange substringRange = NSMakeRange(startRange.location, source.length - endRange.location);
        NSString *substring = [source substringWithRange:substringRange];
        return substring;
    }
    return @"";
}

- (NSString *) cleanHTMLTags: (NSString *) stringToClean
{
    NSString *cleanedString = stringToClean;
    NSString *pattern = @"<(.*)>";
    NSRange rangetoClear = [cleanedString rangeOfString:pattern options:NSRegularExpressionSearch];
    if(rangetoClear.location != NSNotFound)
        do {
            cleanedString = [cleanedString stringByReplacingOccurrencesOfString:[cleanedString substringWithRange:rangetoClear]
                                                                 withString:@""];
            rangetoClear = [cleanedString rangeOfString:pattern options:NSRegularExpressionSearch];
        } while (rangetoClear.location != NSNotFound);
    return cleanedString;
}

@end

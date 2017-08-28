//
//  NearEarthEventDetailModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailModel.h"
#import <UIKit/UIKit.h>

@implementation NearEarthEventDetailModel


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
    
    NSMutableArray *rawData = [NSMutableArray new];
    NSString *pattern;
    
    //1
    pattern = @"<img src=\"(.*)\\\" alt=\"";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //2
    pattern = @"alt=\"(.*)\" title=\"";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //3
    pattern = @"<p class=\"widetitle\" style=\"overflow: hidden;\">(.*)<\\/p>";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //4
    pattern = @"style=\"float:right;margin-right:50px;\">\n(.*)\">";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //5 todo
    pattern = @"<img src=\"(.*)\\\" alt=\"";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //6
    pattern = @"alt=\"(.*)\" title=\"";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //7
    pattern = @"<p class=\"widetitle\" style=\"overflow: hidden;\">(.*)<\\/p>";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //8
    pattern = @"style=\"float:right;margin-right:50px;\">\n(.*)\">";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    //9
    pattern = @"style=\"float:right;margin-right:50px;\">\n(.*)\">";
    [rawData addObject:[self regex:pattern fromRawHTML:rawHTML]];
    
    completion(YES);
}

- (NSString *) regex: (NSString *) pattern fromRawHTML: (NSString *)rawHTML
{
    NSString *rawString;
    NSRange stringRange;
    NSArray *replacements = [pattern componentsSeparatedByString:@"(.*)"];
    
    stringRange = [rawHTML rangeOfString:pattern options:NSRegularExpressionSearch];
    if(stringRange.location == NSNotFound)
        return @"";
    rawString = [rawHTML substringWithRange:stringRange];
    rawString = [rawString stringByReplacingOccurrencesOfString:replacements[0] withString:@""];
    rawString = [rawString stringByReplacingOccurrencesOfString:replacements[1] withString:@""];
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

@end

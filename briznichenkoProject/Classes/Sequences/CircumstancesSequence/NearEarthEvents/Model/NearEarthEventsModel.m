//
//  NearEarthEventsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventsModel.h"


@implementation NearEarthEventsModel


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

- (void) requestEventsHTML: (void (^) (NSString *urlForEvents)) completion
{
    NSString *stringURL = @"https://in-the-sky.org/newscal.php";
    NSURL *url = [NSURL URLWithString:stringURL];
    NSError *error;
    NSString *rawHTML = [NSString stringWithContentsOfURL:url
                                                 encoding:NSASCIIStringEncoding
                                                    error:&error];
    NSArray *htmlComponents = [rawHTML componentsSeparatedByString:@"<div"];
    NSMutableArray *htmlConstructor = [NSMutableArray new];
    
    for(int i = 0; i < htmlComponents.count; i++)
    {
        NSString *component = htmlComponents[i];
        if([component containsString:@"col-xl-2 tallright noprint"])
            break;
        if([component containsString:@"!DOCTYPE"])
            [htmlConstructor addObject:component];
        if([component containsString:@"contentwrapper"])
           [htmlConstructor addObject:[NSString stringWithFormat:@"<div%@", component]];
        if([component containsString:@"mainpage container"])
            [htmlConstructor addObject:[NSString stringWithFormat:@"<div%@", component]];
        if(htmlConstructor.count >= 3)
            [htmlConstructor addObject:[NSString stringWithFormat:@"<div%@", component]];
    }
    [htmlConstructor addObjectsFromArray:@[@"</body>", @"</html>"]];
    NSString *newHTML = @"";
    for (NSString *component in htmlConstructor)
        newHTML = [newHTML stringByAppendingString:component];
    completion(newHTML);
}

@end

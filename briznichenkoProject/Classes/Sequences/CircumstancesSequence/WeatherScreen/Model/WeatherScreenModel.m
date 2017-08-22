//
//  WeatherScreenModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenModel.h"

@implementation WeatherScreenModel
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    CLPlacemark *currentPlacemark;
}


- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startMonitoringSignificantLocationChanges];
        [locationManager startUpdatingLocation];
	}
	return self;
}

#pragma mark -- Networking

-(void) getVisibleStars:(void (^)(NSData *imageData))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        float lat = currentLocation.coordinate.latitude;
        float lon = currentLocation.coordinate.longitude;
        
        NSString *stringURL = [NSString stringWithFormat:@"https://www.fourmilab.ch/cgi-bin/Yourtel?lat=%f&ns=North&lon=%ffov=45&imgsize=2048&z=1", lat, lon];
        NSURL *url = [NSURL URLWithString:stringURL];
        NSError *error;
        NSString *rawHTML = [NSString stringWithContentsOfURL:url
                                                        encoding:NSASCIIStringEncoding
                                                           error:&error];
        long startLoc = [rawHTML rangeOfString:@"<img src=\"/cgi-bin/Yourtel?"].location + [rawHTML rangeOfString:@"<img src=\"/cgi-bin/Yourtel?"].length;
        long endLoc = [rawHTML rangeOfString:@"\" usemap=\"#panmap"].location;
        
        NSString *imageURLString = [rawHTML substringWithRange:NSMakeRange(startLoc, endLoc - startLoc)];
        
        imageURLString = [NSString stringWithFormat:@"https://www.fourmilab.ch/cgi-bin/Yourtel?%@", imageURLString];
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [[CLGeocoder new] reverseGeocodeLocation:currentLocation
                               completionHandler:^(NSArray *array, NSError *error){
                                   if (error){
                                       NSLog(@"Geocode failed with error: %@", error);
                                       return;
                                   }
                                   currentPlacemark = [array objectAtIndex:0];
                                   completionBlock(imageData);
                               }];
    });
}

-(void) getWeatherData: (void (^) (NSDictionary *weatherData)) completion
{
    NSURLSession *urlSession;
    NSURLSessionDataTask *dataTask;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@",
                                       [currentPlacemark.subAdministrativeArea stringByReplacingOccurrencesOfString:@" " withString:@""],
                                       @"49f186e15c83eb0bbc7a734e831b2021"]];
    dataTask = [urlSession
                dataTaskWithURL:url
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(error)
                    {
                        NSLog(@"Error getting weather data: %@", error.localizedDescription);
                        return;
                    }
                    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    completion(jsonData);
                }];
    [dataTask resume];
}

#pragma mark -- Util

- (NSString *) returnLocationString
{
    NSString *stringToReturn = @"";
    stringToReturn = [NSString stringWithFormat:@"%@, %@ (%f, %f)", currentPlacemark.subAdministrativeArea, currentPlacemark.administrativeArea, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    return currentPlacemark ? stringToReturn : @"Please wait, location is being fetched...";
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations lastObject];
}

@end

//
//  AARMovieController.m
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "AARMovieController.h"
#import "AARMovie.h"

//append in said order
static NSString *const baseURLString = @"https://api.themoviedb.org/3/"; //1
static NSString *const searchComponent = @"search"; //2
static NSString *const movieComponent = @"movie/"; //3
static NSString *const apiQuery = @"api_key"; //4-1
static NSString *const apiKey = @"db2916b46a4319f5aa22a803f48226ac"; //4-2
static NSString *const movieSearchQuery = @"query"; //5


@implementation AARMovieController

+(void)fetchMoviesWith:(NSString *)searchTerm
                completion:(void (^)(NSArray<AARMovie *> * _Nullable))completion //nullable completion necessary to complete with nil
{
    //REVIEW -- there is a better way but went with this for now; would like to see it done faster
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:searchComponent];
    NSURL *movieURL = [searchURL URLByAppendingPathComponent:movieComponent];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:movieURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQueryItem = [NSURLQueryItem queryItemWithName:apiQuery value:apiKey];
    NSURLQueryItem *movieSearchQueryItem = [NSURLQueryItem queryItemWithName:movieSearchQuery value:searchTerm];
    
    urlComponents.queryItems = @[apiQueryItem, movieSearchQueryItem];
    NSURL *finalURL = urlComponents.URL;
    //printing finalURL to console to verify json
    NSLog(@"%@", finalURL);
    
    //dataTask
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            completion(nil); return;
        }
        if (response)
        {
            NSLog(@"Response: %@", response);
        }
        if (!data) //REVIEW -- is this a better way to handle data? bottom of dataTask is where we know our data is
        {
            NSLog(@"No data found. /n");
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            completion(nil); return;
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            completion(nil); return;
        }
        
        NSMutableArray *movies = [NSMutableArray new];
        for (NSDictionary *movieDict in jsonDict[@"results"])
        {
            //creating Movie objects init'd and adding to a [Movie]
            AARMovie *movie = [[AARMovie alloc] initWithDictionary:movieDict];
            [movies addObject:movie];
        }
        //copy so as to not cause unexpected behavior
        completion([movies copy]);
    }] resume];
}

@end

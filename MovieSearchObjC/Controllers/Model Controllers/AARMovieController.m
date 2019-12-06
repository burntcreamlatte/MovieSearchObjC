//
//  AARMovieController.m
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "AARMovieController.h"
#import "AARMovie.h"

static NSString *const baseURLString = @"https://api.themoviedb.org/3/";
static NSString *const searchComponent = @"search";
static NSString *const movieComponent = @"movie";
static NSString *const movieQuery = @"query";
static NSString *const apiQuery = @"api_key";
static NSString *const apiKey = @"db2916b46a4319f5aa22a803f48226ac";


@implementation AARMovieController

+(void)fetchMoviesWith:(NSString *)searchTerm
                completion:(void (^)(NSArray<AARMovie *> * _Nullable))completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    NSURLQueryItem *apiQueryItem = [NSURLQueryItem queryItemWithName:apiQuery value:apiKey];
    NSURLQueryItem *searchQueryItem = [NSURLQueryItem queryItemWithName:searchComponent value:searchTerm];
    
    urlComponents.queryItems = @[apiQueryItem, searchQueryItem];
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@", finalURL);
    
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
        if (!data)
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
            AARMovie *movie = [[AARMovie alloc] initWithDictionary:movieDict];
            [movies addObject:movie];
        }
        //copy so as to not cause unexpected behavior
        completion([movies copy]);
    }] resume];
}

@end

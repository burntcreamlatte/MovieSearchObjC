//
//  AARMovie.m
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "AARMovie.h"

//our Obj-C CodingKeys
static NSString *const titleKey = @"original_title";
static NSString *const overviewKey = @"overview";
static NSString *const ratingKey = @"vote_average";

@implementation AARMovie

-(instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(NSNumber *)rating
{
    if (self)
    {
        _title = title;
        _overview = overview;
        _rating = rating;
    }
    return self;
}

@end


@implementation AARMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //passing our CodingKeys to the dictionary init
    NSString *title = dictionary[titleKey];
    NSString *overview = dictionary[overviewKey];
    NSNumber *rating = dictionary[ratingKey];
    
    return [self initWithTitle:title overview:overview rating:rating];
}

@end

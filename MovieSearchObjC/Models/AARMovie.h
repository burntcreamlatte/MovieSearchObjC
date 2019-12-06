//
//  AARMovie.h
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AARMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title; //original_title
@property (nonatomic, copy, readonly) NSString *overview; //overview
@property (nonatomic, copy, readonly) NSNumber *rating; //vote_average

-(instancetype)initWithTitle:(NSString *)title
                    overview:(NSString *)overview
                      rating:(NSNumber *)rating;

@end


@interface AARMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

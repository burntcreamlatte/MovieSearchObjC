//
//  AARMovieController.h
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AARMovie;

NS_ASSUME_NONNULL_BEGIN

@interface AARMovieController : NSObject

+(void)fetchSearchedMovies:(NSString *)searchTerm
                completion:(void(^) (NSArray<AARMovie *> *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END

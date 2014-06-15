//
//  NSJSONSerialization+WeirdJSON.h
//  translator
//
//  Created by thiago on 6/15/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (WeirdJSON)

+ (id)JSONObjectWithWeirdData:(NSData *)data
                      options:(NSJSONReadingOptions)opt
                        error:(NSError **)error;

@end

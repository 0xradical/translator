//
//  Translation.h
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Translation : NSObject

- (BOOL)hasError;
- (NSError *)error;
- (instancetype)initWithData:(NSData *)data
                    andError:(NSError *)error;

@end

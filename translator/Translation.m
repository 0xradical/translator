//
//  Translation.m
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "Translation.h"

@interface Translation ()
{
    @private
    NSData *_data;
    NSError *_error;
}
@end

@implementation Translation

- (instancetype)initWithData:(NSData *)data
                    andError:(NSError *)error
{
    self = [super init];
    
    if (self) {
        _data = data;
        _error = error;
    }
    
    return self;
}

- (BOOL)hasError
{
    return !!_error;
}

- (NSError *)error
{
    return _error;
}

@end

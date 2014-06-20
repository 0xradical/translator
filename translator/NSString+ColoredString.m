//
//  NSString+ColoredString.m
//  translator
//
//  Created by thiago on 6/19/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSString+ColoredString.h"

@implementation NSString (ColoredString)

+ (instancetype)stringWithForeground:(int)foreground
                       andBackground:(int)background
                           andFormat:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:format
                                                            arguments:args];
    
    va_end(args);
    
    return string;
}

@end

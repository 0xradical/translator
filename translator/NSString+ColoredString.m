//
//  NSString+ColoredString.m
//  translator
//
//  Created by thiago on 6/19/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSString+ColoredString.h"

@implementation NSString (ColoredString)

- (instancetype)withTerminalBehavior:(NSTerminalBehavior)behavior
{
    NSMutableString *baseLine = [NSMutableString stringWithString:self];
    
    NSString *behaviorString = [NSString stringWithFormat:@"%c[%ld;%ld;%ldm", 0x1B, behavior.function, behavior.foregroundColor, behavior.backgroundColor];
    
    NSString *reset = [NSString stringWithFormat:@"%c[%d;%d;%dm", 0x1B, RESET, WHITE, BLACK];
    
    [baseLine insertString:behaviorString atIndex:0];
    [baseLine insertString:reset atIndex:[baseLine length]];
    
    return baseLine;
    
}

@end

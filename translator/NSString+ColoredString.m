//
//  NSString+ColoredString.m
//  translator
//
//  Created by thiago on 6/19/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSString+ColoredString.h"

const NSTerminalBehavior NSTerminalBehaviorBold = {
    BRIGHT, WHITE + 30, BLACK + 40
};

const NSTerminalBehavior NSTerminalBehaviorDimmed = {
    DIM, WHITE + 30, BLACK + 40
};

@implementation NSString (ColoredString)

- (instancetype)withTerminalBehavior:(NSTerminalBehavior)behavior
{
    NSString *baseLine = [NSString stringWithString:self];
    
    NSString *stringWithBehavior = [NSString stringWithFormat:@"\e[%ld;%ld;%ldm%@\e[0m", behavior.function, behavior.foregroundColor, behavior.backgroundColor, baseLine];
    
    return stringWithBehavior;
}

@end

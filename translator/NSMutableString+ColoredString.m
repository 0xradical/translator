//
//  NSMutableString+ColoredString.m
//  translator
//
//  Created by thiago on 6/20/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSMutableString+ColoredString.h"

@interface NSMutableString ()
{
    NSInteger _currentTerminalBehavior;
    NSInteger _currentBackgroundColor;
    NSInteger _currentForegroundColor;
}
@end

@implementation NSMutableString (ColoredString)

- (void)terminalBehavior:(NSInteger)terminalBehavior
{
    _currentTerminalBehavior = terminalBehavior;
    
    NSString *command = [[NSString stringWithFormat:@"%c[%ld;%ld;%ldm", 0x1B, (long)[self currentTerminalBehavior], [self currentForegroundColor] + 30, [self currentBackgroundColor] + 40]];
    
    NSString *reset = [NSString stringWithFormat:@"%c[%d;%d;%dm", 0x1B, RESET, WHITE + 30, BLACK + 40];
    
    [self insertString:command atIndex:0];
    [self insertString:reset atIndex:[self length]];
}

- (NSInteger)currentTerminalBehavior
{
    if (_currentTerminalBehavior) {
        return _currentTerminalBehavior;
    } else {
        return RESET;
    }
    
}

- (NSInteger)currentForegroundColor
{
    if (_currentForegroundColor) {
        return _currentForegroundColor;
    } else {
        return WHITE;
    }
}

- (NSInteger)currentBackgroundColor
{
    if (_currentBackgroundColor) {
        return _currentBackgroundColor;
    } else {
        return BLACK;
    }
}

@end

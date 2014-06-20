//
//  NSString+ColoredString.h
//  translator
//
//  Created by thiago on 6/19/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>

// As per http://www.linuxjournal.com/article/8603

#define RESET       0
#define BRIGHT      1
#define DIM         2
#define UNDERLINE   3
#define BLINK       4
#define REVERSE     7
#define HIDDEN      8

#define BLACK       0
#define RED         1
#define GREEN       2
#define YELLOW      3
#define BLUE        4
#define MAGENTA     5
#define CYAN        6
#define WHITE       7

#define RESET       0
#define BRIGHT      1
#define DIM         2
#define UNDERLINE   3
#define BLINK       4
#define REVERSE     7
#define HIDDEN      8

#define BLACK       0
#define RED         1
#define GREEN       2
#define YELLOW      3
#define BLUE        4
#define MAGENTA     5
#define CYAN        6
#define WHITE       7

typedef struct _NSTerminalBehavior {
    NSUInteger function;
    NSUInteger foregroundColor;
    NSUInteger backgroundColor;
} NSTerminalBehavior;

NS_INLINE NSTerminalBehavior NSMakeTerminalBehavior(NSUInteger func, NSUInteger fgcolor, NSUInteger bgcolor) {
    NSTerminalBehavior tb;
    
    tb.function = func;
    tb.foregroundColor = fgcolor + 30;
    tb.backgroundColor = bgcolor + 40;
    
    return tb;
}

@interface NSString (ColoredString)

- (instancetype)withTerminalBehavior:(NSTerminalBehavior)behavior;

@end

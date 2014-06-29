//
//  NSString+ColoredString.h
//  translator
//
//  Created by thiago on 6/19/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>

// Terminal Escape Codes
// As per http://www.linuxjournal.com/article/8603, with some minor fixes
// The "WHITE" color is actually GRAY, dude is clueless!
// Also, I just use \e[0m as RESET, much simpler
// Also, this: http://misc.flogisoft.com/bash/tip_colors_and_formatting

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
#define GRAY        7
#define WHITE       8

typedef struct _NSTerminalBehavior {
    NSUInteger function;
    NSUInteger foregroundColor;
    NSUInteger backgroundColor;
} NSTerminalBehavior;

extern const NSTerminalBehavior NSTerminalBehaviorBold;
extern const NSTerminalBehavior NSTerminalBehaviorDimmed;

@interface NSString (ColoredString)

- (instancetype)withTerminalBehavior:(NSTerminalBehavior)behavior;

@end

//
//  NSPagedPrint.m
//  translator
//
//  Created by thiago on 6/29/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSPagedPrint.h"

// helper function to print NSStrings to STDOUT
void NSPagedPrint(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    // the -r argument makes less
    // handle terminal escape codes correctly
    FILE *less = popen("less -r", "w");
    fprintf(less, "%s\n", [string UTF8String]);
    pclose(less);
    
}

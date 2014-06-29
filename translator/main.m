//
//  main.m
//  translator
//
//  Created by thiago on 6/10/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Translator.h"
#import "Translation.h"
#import "NSPrint.h"
#import "NSPagedPrint.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if (argc < 2) {
            NSPrint(@"Not enough arguments.");
            return 1;
        }
        else {
            NSError *error;
            NSRegularExpression *whiteSpaceRegex;
            NSMutableString *query;
            Translator *translator;
            Translation *translation;
            
            query = [NSMutableString stringWithUTF8String:argv[1]];
            
            // substitute params like "United    Kingdom" for "United%20Kingdom"
            whiteSpaceRegex = [NSRegularExpression regularExpressionWithPattern:@"\\s+"
                                                                        options:0
                                                                          error:NULL];
            
            [whiteSpaceRegex replaceMatchesInString:query
                                            options:0
                                              range:NSMakeRange(0, [query length])
                                       withTemplate:@"%20"];
            
            translator = [[Translator alloc] init];
            
            translation = [translator translate:query
                                          error:&error];
            
            if (error) {
                NSPrint(@"%@", error);
            }
            else {
                NSPagedPrint(@"%@", translation);
            }
                        
        }
        
    }
    return 0;
}


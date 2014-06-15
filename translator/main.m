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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if (argc < 1) {
            NSPrint(@"Not enough arguments.");
            return 1;
        }
        else {
            NSError *error;
            NSString *query;
            Translator *translator;
            Translation *translation;
            
            query = [NSString stringWithUTF8String:argv[1]];
            
            translator = [[Translator alloc] init];
            
            translation = [translator translate:query
                                          error:&error];
            
            if (error) {
                NSPrint(@"%@", error);
            }
            else {
                NSPrint(@"%@", translation);
            }
                        
        }
        
    }
    return 0;
}


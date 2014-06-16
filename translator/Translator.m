//
//  Translator.m
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "Translator.h"
#import "Translation.h"
#import "NSJSONSerialization+WeirdJSON.h"

static NSString* URLFormat = @"https://translate.google.com/translate_a/single?client=t&sl=auto&tl=pt&hl=en&dt=bd&dt=ex&dt=ld&dt=md&dt=qc&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&prev=enter&ssel=0&tsel=4&q=%@";

@implementation Translator

- (Translation *)translate:(NSString *)query
                     error:(NSError *__autoreleasing *)error
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:URLFormat, query]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *connectionError = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&connectionError];
    
    if (connectionError) {
        *error = connectionError;
        return nil;
    }
    else {
        
        NSError *deserializationError = nil;
        
        NSArray *translationContents = [NSJSONSerialization JSONObjectWithWeirdData:data
                                                                            options:0
                                                                              error:&deserializationError];
        if (deserializationError) {
            *error = deserializationError;
            return nil;
        }
        else {
            return [[Translation alloc] initWithContents:translationContents];
        }
    }
}

@end

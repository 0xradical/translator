//
//  NSJSONSerialization+WeirdJSON.m
//  translator
//
//  Created by thiago on 6/15/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "NSJSONSerialization+WeirdJSON.h"

@implementation NSJSONSerialization (WeirdJSON)

+ (id)JSONObjectWithWeirdData:(NSData *)data
                      options:(NSJSONReadingOptions)opt
                        error:(NSError *__autoreleasing *)error
{
    
    NSString *dataString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    
    // Sanitize dataString
    // dataString is almost a JSON
    // except it containts contiguous commas
    // that get substituted by null-interspaced commas
    // by regular Javascript parsers
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((?<=\\,)\\,)|(\\[\\,)|(\\,\\])"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:NULL];
    
    NSArray *matches = [regex matchesInString:stringData
                                      options:0
                                        range:NSMakeRange(0, [stringData length])];
    
    NSMutableString *mutableData = [stringData mutableCopy];
    NSMutableString *template;
    NSString *matchedText;
    //            NSInteger consideredLength;
    
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        matchedText = [mutableData substringWithRange:[match range]];
        
        if ([matchedText isEqualTo:@",,"]) {
            template = [NSMutableString stringWithString:@",null,"];
        } else if ([matchedText isEqualTo:@"[,"]) {
            template = [NSMutableString stringWithString:@"[null,"];
        } else if ([matchedText isEqualTo:@",]"]) {
            template = [NSMutableString stringWithString:@",null]"];
        } else {
            template = [NSMutableString string];
        }
        
        //                consideredLength = [matchedText length] - 1;
        
        //                if ([[matchedText substringFromIndex:[matchedText length]] isEqualToString:@"]"]){
        //                    consideredLength -= 1; // remove the bracket from the count
        //
        //                    template = [NSMutableString stringWithString:@""];
        //
        //                    for (int i = 0; i < consideredLength; i++) {
        //                        [template appendString:@",null"];
        //                    }
        //
        //                    [template appendString:@"]"];
        //
        //                }
        //                else {
        //                    if ([[matchedText substringToIndex:1] isEqualToString:@"["]) {
        //                        consideredLength -= 1;
        //                        template = [NSMutableString stringWithString:@"["];
        //                    }
        //                    else {
        //                        template = [NSMutableString stringWithString:@","];
        //                    }
        //
        //                    for (int i = 0; i < consideredLength; i++) {
        //                        [template appendString:@"null,"];
        //                    }
        //                }
        
        
        [mutableData replaceCharactersInRange:[match range] withString:template];
    }
    
    
    NSData* newData = [mutableData dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:newData
                                            options:opt
                                              error:error];

}

@end

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
    
    NSMutableString *dataString = [[NSMutableString alloc] initWithData:data
                                                               encoding:NSUTF8StringEncoding];
    
    // Sanitize dataString
    // dataString is almost a JSON
    // except it containts contiguous commas
    // that get substituted by null-interspaced commas
    // by regular Javascript parsers
    
    // Treat [, and ,] cases
    [dataString replaceOccurrencesOfString:@"[,"
                                withString:@"[null,"
                                   options:NSCaseInsensitiveSearch
                                     range:NSMakeRange(0, [dataString length])];
    
    [dataString replaceOccurrencesOfString:@",]"
                                withString:@",null]"
                                   options:NSCaseInsensitiveSearch
                                     range:NSMakeRange(0, [dataString length])];
    
    // Treat ,,+ cases, only substitute those commas
    // who have a comma looking behind
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=\\,)\\,"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:NULL];
    
    NSArray *matches = [regex matchesInString:dataString
                                      options:0
                                        range:NSMakeRange(0, [dataString length])];
    
    NSMutableString *template;
    NSString *matchedText;
    
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        matchedText = [dataString substringWithRange:[match range]];
        
        if ([matchedText isEqualTo:@",,"]) {
            template = [NSMutableString stringWithString:@",null,"];
        } else if ([matchedText isEqualTo:@"[,"]) {
            template = [NSMutableString stringWithString:@"[null,"];
        } else if ([matchedText isEqualTo:@",]"]) {
            template = [NSMutableString stringWithString:@",null]"];
        } else {
            template = [NSMutableString string];
        }
        
        [dataString replaceCharactersInRange:[match range] withString:template];
    }
    
    
    NSData* sanitizedData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:sanitizedData
                                            options:opt
                                              error:error];

}

@end

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

// helper function to print NSStrings to STDOUT
static void NSPrint(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    fprintf(stdout, "%s\n", [string UTF8String]);
}


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
            Translator *tor;
            Translation *ton;
            
            query = [NSString stringWithUTF8String:argv[1]];
            
            tor = [[Translator alloc] initWithQuery:query];
            
            ton = [tor translate];
            
            if ([ton hasError]) {
                NSPrint(@"%@", [[ton error] description]);
            }
            else {
                NSPrint(@"%@", [ton description]);
            }
            
        }
        
        
        
        if (data) {
            NSString *stringData = [[NSString alloc] initWithData:data
                                                         encoding:NSUTF8StringEncoding];
            
            // Sanitize stringData
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
            
            
            NSData* data = [mutableData dataUsingEncoding:NSUTF8StringEncoding];
            
            NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:&error];
         
            if (error) {
                // `wow' returns error ...
//                NSPrint(@"%@", [error description]);
                NSPrint(@"%@", mutableData);
//                NSPrint(@"%@", stringData);
            }
            else {
                @try {
//                    NSLog(@"%@", results);
//                    NSLog(@"%@", mutableData);
//                    NSLog(@"%@", results[0][0][1]);
                    
                    NSString *translation = results[0][0][0];
                    NSString *pronunciation = results[0][1][3];
                    NSString *grammarClass = results[1][0][0];
                    NSString *definition = results[12][0][1][0][0];
                    NSString *example = results[12][0][1][0][2];
                    
                    if ([translation isEqualTo:query]) {
                        NSPrint(@"No translation found for %@", query);
                    }
                    else {
                        NSPrint(@"Translations of %@ |%@| ▶%@", query, pronunciation, grammarClass);
                        
                        for (NSArray *alternates in results[1][0][2]) {
                            NSPrint(@"(%@) %@: %@",
                                    alternates[4],
                                    alternates[0],
                                    [alternates[1] componentsJoinedByString:@", "]);
                        }
                        
                        NSPrint(@"Definitions of %@ ▶%@", query, grammarClass);
                        NSPrint(@"%@", definition);
                        NSPrint(@"%@", example);
                    }

                }
                @catch (NSException *exception) {
                    NSPrint(@"No translation found for %@", query);
                }
            }
        }
        else {
            NSPrint(@"%@",[error description]);
        }
        
    }
    return 0;
}


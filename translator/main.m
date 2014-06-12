//
//  main.m
//  translator
//
//  Created by thiago on 6/10/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {

//        NSString *format = @"http://translate.google.com.br/translate_a/t?client=t&hl=pt-BR&sl=en&tl=pt&ie=UTF-8&oe=UTF-8&multires=1&prev=enter&oc=1&ssel=0&tsel=0&sc=1&q=%@";

        NSString *format = @"https://translate.google.com/translate_a/single?client=t&sl=auto&tl=pt&hl=en&dt=bd&dt=ex&dt=ld&dt=md&dt=qc&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&prev=enter&ssel=0&tsel=4&q=%@";
        
        NSString *query = [NSString stringWithUTF8String:argv[1]];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:format, query]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                         error:&error];
        if (data) {
            NSString *stringData = [[NSString alloc] initWithData:data
                                                         encoding:NSUTF8StringEncoding];
            
            // Sanitize stringData
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@",,+"
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:NULL];
            
            NSArray *matches = [regex matchesInString:stringData
                                              options:0
                                                range:NSMakeRange(0, [stringData length])];
            
            NSMutableString *mutableData = [stringData mutableCopy];
            NSMutableString *template;
            NSString *matchedText;
            
            for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
                matchedText = [mutableData substringWithRange:[match range]];
                
                template = [NSMutableString stringWithString:@","];
                
                for (int i = 0; i < [matchedText length] - 1; i++) {
                    [template appendString:@"null,"];
                }
                
                [mutableData replaceCharactersInRange:[match range] withString:template];
            }
            
            
            NSData* data = [mutableData dataUsingEncoding:NSUTF8StringEncoding];
            
            NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:&error];
         
            if (error) {
                NSLog(@"%@", [error description]);
            }
            else {
//                NSLog(@"%@", results);
                NSLog(@"%@", mutableData);
//                NSLog(@"%@", results[0][0][1]);
                
            }
        }
        else {
            NSLog(@"%@",[error description]);
        }
        
    }
    return 0;
}


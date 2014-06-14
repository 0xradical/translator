//
//  Translator.m
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "Translator.h"
#import "Translation.h"

static NSString* URLFormat = @"https://translate.google.com/translate_a/single?client=t&sl=auto&tl=pt&hl=en&dt=bd&dt=ex&dt=ld&dt=md&dt=qc&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&prev=enter&ssel=0&tsel=4&q=%@";

@interface Translator ()
{
    @private
    NSString *_query;
    
}
@end

@implementation Translator

- (instancetype)initWithQuery:(NSString *)query
{
    self = [super init];
    
    if (self) {
        _query = query;
    }
    
    return self;
}

- (Translation *)translate
{
    NSURL *url;
    NSURLRequest *request;
    NSURLResponse *response;
    NSError *error;
    NSData *data;

    
    url = [NSURL URLWithString:[NSString stringWithFormat:URLFormat, _query]];
    
    request = [NSURLRequest requestWithURL:url];
    
    data = [NSURLConnection sendSynchronousRequest:request
                                 returningResponse:&response
                                             error:&error];

    
    return [[Translation alloc] initWithData:data andError:error];
}


@end

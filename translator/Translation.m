//
//  Translation.m
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "Translation.h"

@interface Translation ()
{
    @private
    NSArray *_contents;
}

@end

@implementation Translation

- (instancetype)initWithContents:(NSArray *)contents
{
    self = [super init];
    
    if (self) {
        _contents = contents;
    }
    
    return self;
}

- (NSString *)description
{

    NSMutableString *result = [NSMutableString string];
    
    NSString *translation   = _contents[0][0][0];
    NSString *query         = _contents[0][0][1];
    NSString *pronunciation = _contents[0][1][3];
    
    if ([translation isEqualTo:query]) {
        [result appendString:[NSString stringWithFormat:@"No translation found for %@\n", query]];
    }
    else {
        [result appendString:[NSString stringWithFormat:@"%@ |%@|: %@\n\n", query, pronunciation, translation]];
        
        NSString *grammarClass;
        NSString *article;
        NSString *alternate;
        NSArray *alternateTranslations;
        
        for (int grammarClassIndex = 0;
             grammarClassIndex < [_contents[1] count];
             grammarClassIndex++) {
            grammarClass = _contents[1][grammarClassIndex][0];
            
            [result appendString:[NSString stringWithFormat:@"Translations of %@ ▶%@\n\n", query, grammarClass]];
            
            for (NSArray *alternates in _contents[1][grammarClassIndex][2]) {
                alternate = alternates[0];
                alternateTranslations = alternates[1];
                
                // Noun entries have an extra for article
                if ([alternates count] == 5) {
                    article = alternates[4];
                    
                    [result appendString:[NSString stringWithFormat:@"(%@) %@: %@\n",
                                          article,
                                          alternate,
                                          [alternateTranslations componentsJoinedByString:@", "]]];

                } else {
                    [result appendString:[NSString stringWithFormat:@"%@: %@\n",
                                          alternate,
                                          [alternateTranslations componentsJoinedByString:@", "]]];
                    
                }
                
            }
            
            [result appendString:@"\n"];
        }

        NSString *definition;
        NSString *example;
        
        for (int grammarClassIndex = 0;
             grammarClassIndex < [_contents[12] count];
             grammarClassIndex++) {
            grammarClass = _contents[12][grammarClassIndex][0];
            
            [result appendString:[NSString stringWithFormat:@"Definitions of %@ ▶%@\n\n", query, grammarClass]];
            
            for (NSArray *definitionsAndExamples in _contents[12][grammarClassIndex][1]) {
                definition = definitionsAndExamples[0];
                example = definitionsAndExamples[2];
                
                [result appendString:[NSString stringWithFormat:@"%@\n", definition]];
                [result appendString:[NSString stringWithFormat:@"\"%@\"\n", example]];
                [result appendString:@"\n"];
                
            }
            
        }
        
    }
    
    return result;
    
}

@end
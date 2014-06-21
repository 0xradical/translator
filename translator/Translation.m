//
//  Translation.m
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import "Translation.h"
#import "NSString+ColoredString.h"

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
    
    NSString *pronunciation = nil;
    
    if ([_contents[0] count] > 1) {
        pronunciation = _contents[0][1][3];
    }
    
    NSString *header;
    
    if (pronunciation && [pronunciation length] > 0) {
        header = [NSString stringWithFormat:@"%@ |%@|: %@\n\n", query, pronunciation, translation];
        
    } else {
        header = [NSString stringWithFormat:@"%@: %@\n\n", query, translation];
    }
    
    header = [header withTerminalBehavior:NSTerminalBehaviorBold];

    [result appendString:header];
    
    // if has any translation
    if ([_contents count] > 1 && (id)_contents[1] != [NSNull null]) {
        
        NSString *alternatesHeader;
        NSString *grammarClass;
        NSString *article;
        NSString *alternate;
        NSArray *alternateTranslations;
        
        for (int grammarClassIndex = 0;
             grammarClassIndex < [_contents[1] count];
             grammarClassIndex++) {
            grammarClass = _contents[1][grammarClassIndex][0];
            
            alternatesHeader = [NSString stringWithFormat:@"Translations of %@ ▶%@\n\n", query, grammarClass];
            
            [result appendString:[alternatesHeader withTerminalBehavior:NSTerminalBehaviorBold]];
            
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

    }
    
    // if has any definition
    if ([_contents count] > 12 && (id)_contents[12] != [NSNull null]) {
        
        NSString *definitionHeader;
        NSString *grammarClass;
        NSString *definition;
        NSString *example;
        
        for (int grammarClassIndex = 0;
             grammarClassIndex < [_contents[12] count];
             grammarClassIndex++) {
            grammarClass = _contents[12][grammarClassIndex][0];
            
            definitionHeader = [NSString stringWithFormat:@"Definitions of %@ ▶%@\n\n", query, grammarClass];
            
            [result appendString:[definitionHeader withTerminalBehavior:NSTerminalBehaviorBold]];
            
            for (NSArray *definitionsAndExamples in _contents[12][grammarClassIndex][1]) {
                definition = definitionsAndExamples[0];
                [result appendString:[NSString stringWithFormat:@"%@\n", definition]];
                
                if ([definitionsAndExamples count] > 2) {
                    example = [NSString stringWithFormat:@"\"%@\"\n", definitionsAndExamples[2]];
                    [result appendString:[example withTerminalBehavior:NSTerminalBehaviorDimmed]];
                }
                
                [result appendString:@"\n"];
                
            }
            
        }

    }
    
    return result;
    
}

@end

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
    
    NSString *query = _contents[0][0][1];
    NSString *translation = _contents[0][0][0];
    NSString *pronunciation = _contents[0][1][3];
    NSString *grammarClass = _contents[1][0][0];
    NSString *definition = _contents[12][0][1][0][0];
    NSString *example = _contents[12][0][1][0][2];
    
    if ([translation isEqualTo:query]) {
        [result appendString:[NSString stringWithFormat:@"No translation found for %@\n", query]];
    }
    else {
        [result appendString:[NSString stringWithFormat:@"Translations of %@ |%@| ▶%@\n", query, pronunciation, grammarClass]];
        
        for (NSArray *alternates in _contents[1][0][2]) {
            [result appendString:[NSString stringWithFormat:@"(%@) %@: %@\n",
                                                            alternates[4],
                                                            alternates[0],
                                                            [alternates[1]
                                   componentsJoinedByString:@", "]]];
        }
        
        [result appendString:[NSString stringWithFormat:@"Definitions of %@ ▶%@\n", query, grammarClass]];
        [result appendString:[NSString stringWithFormat:@"%@\n%@\n", definition, example]];
    }
    
    return result;
    
}

@end

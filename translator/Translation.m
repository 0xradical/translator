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

    @try {
        
        NSString *query = _contents[0][0][1];
        NSString *translation = _contents[0][0][0];
        NSString *pronunciation = _contents[0][1][3];
        NSString *grammarClass = _contents[1][0][0];
        NSString *definition = _contents[12][0][1][0][0];
        NSString *example = _contents[12][0][1][0][2];
        
        if ([translation isEqualTo:query]) {
            NSPrint(@"No translation found for %@", query);
        }
        else {
            NSPrint(@"Translations of %@ |%@| ▶%@", query, pronunciation, grammarClass);
            
            for (NSArray *alternates in _contents[1][0][2]) {
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

@end

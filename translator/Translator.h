//
//  Translator.h
//  translator
//
//  Created by thiago on 6/14/14.
//  Copyright (c) 2014 thiagobrandam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Translation;

@interface Translator : NSObject

- (instancetype)initWithQuery:(NSString *)query;
- (Translation *)translate;

@end

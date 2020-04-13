//
//  News.m
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "News.h"

@implementation News 
- (instancetype)init
{
    self = [super init];
    if (self) {
        _saved = NO;
    }
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.publishedAt forKey:@"publishedAt"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.urlToImage forKey:@"urlToImage"];
    [coder encodeBool:self.saved forKey:@"saved"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    self = [super init];
    self.content = [coder decodeObjectForKey:@"content"];
    self.publishedAt = [coder decodeObjectForKey:@"publishedAt"];
    self.title = [coder decodeObjectForKey:@"title"];
    self.url = [coder decodeObjectForKey:@"url"];
    self.urlToImage = [coder decodeObjectForKey:@"urlToImage"];
    self.saved = [coder decodeBoolForKey:@"saved"];
    return self;
}

@end

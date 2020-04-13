//
//  NewsListModel.m
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel

+(id) shared {
    static NewsListModel *model = nil;
    @synchronized (self) {
        if (model == nil) {
            model = [[self alloc] init];
        }
    }
    return model;
}

-(void) getNewsWithcompletion: (void (^)(NSArray *news))callback{
    // Fetch News from URL
    NSString *newsUrlString = @"https://moedemo-93e2e.firebaseapp.com/assignment/NewsApp/articles.json";
    NSURL *url = [[NSURL alloc] initWithString:newsUrlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        NSArray *array = [self dataFromJson: data];
        callback(array);
    }] resume];
    
}

- (NSArray *) dataFromJson: (NSData *) data {
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *newsList = [[NSMutableArray alloc] init];
    NSArray *articles = [dataDictionary valueForKey:@"articles"];
    
    for (NSDictionary *article in  articles) {
        News *news = [[News alloc] init];
        
        for (NSString *key in article) {
            if ([news respondsToSelector:NSSelectorFromString(key)])   {
                if(![key isEqualToString: @"description"]) {
                     [news setValue:[article valueForKey:key] forKey:key];
                }
               
            }
        }
        
       [newsList addObject:news];
    };
    NSLog(@"Count %lu", (unsigned long)newsList.count);
    return newsList;
}

@end

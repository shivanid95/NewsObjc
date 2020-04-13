//
//  NewsViewModel.h
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN


@protocol NewsViewModelDelegate <NSObject>
- (void) newsDataDidUpdate;

@end

@interface NewsViewModel : NSObject <NSURLSessionDelegate, NSURLSessionDownloadDelegate>  {
    NSArray *articles ;
}


@property (nonatomic, weak) id <NewsViewModelDelegate> delegate;

- (NSInteger) numberOfNewstems;
- (News *)itemAt: (NSInteger) index;
- (void)fetchNewsArticles;
- (NSString *)formatDate: (NSString *) str;
- (void)sort: (BOOL) ascending ;
- (void)saveArticle: (NSInteger ) index;
- (NSURL *) getWebUrl:(NSInteger) index;
@end

NS_ASSUME_NONNULL_END

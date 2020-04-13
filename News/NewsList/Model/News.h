//
//  News.h
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject <NSCoding>
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *urlToImage;
@property (strong, nonatomic) NSString *publishedAt;
@property Boolean saved ;
@end

NS_ASSUME_NONNULL_END

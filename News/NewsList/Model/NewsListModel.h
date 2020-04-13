//
//  NewsListModel.h
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

//NS_ASSUME_NONNULL_BEGIN

@interface NewsListModel : NSObject

-(void) getNewsWithcompletion: (void (^)(NSArray *news))callback;

- (NSArray *) dataFromJson: (NSData *) data;

+(id) shared;

@end

//NS_ASSUME_NONNULL_END

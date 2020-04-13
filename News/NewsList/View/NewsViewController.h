//
//  NewsViewController.h
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItemCell.h"
#import "NewsViewModel.h"
#import "NewsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : UITableViewController <NewsViewModelDelegate, NewsCellDelegate>

- (instancetype)initWithViewModel:(NewsViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END

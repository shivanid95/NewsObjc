//
//  NewsItemCell.h
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsCellDelegate <NSObject>

-(void)didTapSaveButton: (NSInteger )index;

@end

//NS_ASSUME_NONNULL_BEGIN

@interface NewsItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveNewsButton;

@property (weak, nonatomic) id <NewsCellDelegate> delegate;

@property NSInteger index;

- (void) setSaved: (Boolean) saved ;
- (void) setImage:(NSURL *)imageUrl;

- (IBAction)didTapSaveNews:(UIButton *)sender;

@end

//NS_ASSUME_NONNULL_END

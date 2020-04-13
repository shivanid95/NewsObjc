//
//  NewsItemCell.m
//  News
//
//  Created by Shivani on 10/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "NewsItemCell.h"

@implementation NewsItemCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _saveNewsButton.backgroundColor = UIColor.systemGreenColor;
    _saveNewsButton.layer.cornerRadius = 4;
    _saveNewsButton.titleLabel.textColor = UIColor.whiteColor;
    [_saveNewsButton setTintColor:UIColor.whiteColor];
    // Initialization code
}

- (void)layoutSubviews {
    
    self.containerView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    self.containerView.layer.borderWidth = 1.0;
    self.containerView.layer.cornerRadius = 4;
    
}

-(void) prepareForReuse {
    
    [super prepareForReuse];
    
    self.newsImageView.image = NULL;
    self.titleLabel.text = @"" ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - Actions

- (IBAction)didTapSaveNews:(UIButton *)sender {
    if (&index != NULL) {
        [self.delegate didTapSaveButton: _index];
    }
    
}

#pragma mark - Utility

-(void) setSaved:(Boolean)saved {
    if (saved) {
        
        [_saveNewsButton setTitle:@"✓ Saved" forState: UIControlStateNormal];
        _saveNewsButton.backgroundColor = UIColor.darkGrayColor ;
    }
    else {
        [_saveNewsButton setTitle:@"⚡︎ Save" forState: UIControlStateNormal];
        _saveNewsButton.backgroundColor = UIColor.systemTealColor ;
    }
}

- (void) setImage:(NSURL *)imageUrl {
    
    self.newsImageView.image = NULL;
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([response.URL isEqual:imageUrl]) {
                        self.newsImageView.image = image;
                    } else {
                        self.newsImageView.image = NULL;
                    }
                });
            }
        }
    }];
    
    [task resume];
}
@end

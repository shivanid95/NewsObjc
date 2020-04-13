//
//  NewsViewController.m
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "NewsViewController.h"
#import "ArticleWebViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong, readonly) NewsViewModel *viewModel;

@end

@implementation NewsViewController

static NSString *cellReuseId = @"SimpleTableItem";
static NSString *sortUp = @"Sort ⇧";
static NSString *sortDown = @"Sort ⇩";

#pragma mark - Initialize

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [_viewModel fetchNewsArticles];
    
}

- (void) setup {
    // Setup Navigation Button
    self.title = @"News";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: sortUp style:UIBarButtonItemStylePlain target:self action:@selector(didTapSort)];
    
    // Setup Table Views
    [self.tableView registerNib: [UINib nibWithNibName:@"NewsItemCell" bundle:nil] forCellReuseIdentifier: cellReuseId];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (instancetype)initWithViewModel:(NewsViewModel *)viewModel {
    
    self = [super initWithStyle: UITableViewStylePlain];
    if (!self) {
        return nil;
        
    }
    _viewModel = viewModel;
    _viewModel.delegate =  self;
    return self;
    
};

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfNewstems];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsItemCell *cell = (NewsItemCell *)[tableView dequeueReusableCellWithIdentifier: cellReuseId forIndexPath:indexPath];
    cell.index = indexPath.item ;
    cell.delegate = self;
    
    News *news = [_viewModel itemAt:indexPath.item];
    
    if (news != NULL) {
        cell.titleLabel.text = news.title;
        cell.dateLabel.text = news.publishedAt;
        cell.dateLabel.text = [_viewModel formatDate:news.publishedAt];
        [cell setSaved:news.saved];
        NSURL *url = [[NSURL alloc] initWithString:news.urlToImage];
        [cell setImage: url];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.99;
}

#pragma mark - Utility

- (void)newsDataDidUpdate {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

-(void) didTapSort {
    Boolean isAscending;
    
    if (self.navigationItem.rightBarButtonItem.title == sortUp) {
        isAscending = YES;
    }
    else {
        isAscending = NO;
    }
    
    if (isAscending) {
        self.navigationItem.rightBarButtonItem.title = sortDown;
    }
    else {
        self.navigationItem.rightBarButtonItem.title = sortUp;
    }
    
    [_viewModel sort:isAscending];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create the next view controller.
    ArticleWebViewController *articleController = [[ArticleWebViewController alloc] initWithNibName:@"ArticleWebViewController" bundle: nil];
    
    // Pass the selected object to the new view controller.
    articleController.newsURL = [_viewModel getWebUrl:indexPath.item];
    
    // Push the view controller.
    [self.navigationController pushViewController:articleController animated:YES];
}

#pragma mark - News Cell Delegate

-(void)didTapSaveButton:(NSInteger )index {
    [_viewModel saveArticle: index];
}

@end

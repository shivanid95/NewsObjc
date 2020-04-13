//
//  NewsViewModel.m
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsListModel.h"


@implementation NewsViewModel
NSInteger urlIndex ;
static NSString *KEY = @"articles";


-(void) fetchNewsArticles {
    
    NSArray *array = [self getDataFromUserDefaults];
    
    if (array != NULL ) {
        articles = array;
        [self->_delegate newsDataDidUpdate];
        return;
    }
    __typeof(self) __weak weakSelf = self;
    [NewsListModel.shared getNewsWithcompletion:^(NSArray *news) {
    typeof(self)  strongSelf = weakSelf;
        
        strongSelf->articles = [[NSArray alloc]  initWithArray:news];
        [strongSelf->_delegate newsDataDidUpdate];
        [strongSelf saveArticlesToUserDefaults];
        
    }];
}

-(NSInteger) numberOfNewstems {
    
    if (self->articles != NULL) {
        return articles.count;
    }
    return 0;
};

-(News *)itemAt: (NSInteger) index {
    
    if (self->articles != NULL && index < articles.count) {
        return articles[index];
        
    }
    return NULL;
};

-(void)sort: (BOOL) ascending {
    
    self->articles = [articles sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        NSString *first = [(News *)a publishedAt];
        NSDate *date1 = [self dateFrom: first];
        NSString *second = [(News *)b publishedAt];
        NSDate *date2 = [self dateFrom:second];
        
        if (ascending) {
            return [date1 compare:date2];
        }
        else {
            return [date2 compare:date1];
        }
        
    }];
    
    [_delegate newsDataDidUpdate];
}


-(NSDate *) dateFrom: (NSString *)dateString {
    
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *date = [[NSDate alloc] init];
    date = [formatter dateFromString:dateString];
    return  date;
}

-(NSString *)formatDate: (NSString *) str {
    
    NSDate *date = [self dateFrom:str];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MMM-yyyy HH:mm";
    
    return [formatter stringFromDate:date];
}


-(void)saveArticle: (NSInteger ) index {
    NSString *urlString = [self itemAt:index].url;
    urlIndex = index;
    
    if ([self doesFileExists:index]) {
        return ;
    }
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL: url];
    [downloadTask resume];
    
}


-(Boolean)doesFileExists: (NSInteger ) index {
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [self getFilePath:index]];
    return [[NSFileManager defaultManager] fileExistsAtPath:fileURL.path isDirectory: FALSE];
}

-(NSString *) getFilePath: (NSInteger) index {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    return  [docPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.html", [self itemAt:index].publishedAt]];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSString *path = [self getFilePath: urlIndex] ;
    
    if ([[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:NULL]) {
        NSLog(@"Success");
        [self updateSaveState];
    }
    else {
        NSLog(@"Failiure");
    }
    
    
}


- (void) saveArticlesToUserDefaults {
    
    // Determine Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:articles requiringSecureCoding:YES error:NULL];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
    
}

- (NSArray *) getDataFromUserDefaults {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
    
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
}

-(void)updateSaveState {
    
    [self itemAt:urlIndex].saved = YES;
    [self saveArticlesToUserDefaults];
    [_delegate newsDataDidUpdate];
    
}
-(NSURL *) getWebUrl:(NSInteger) index {
    
    if ([self doesFileExists: index]) {
        
        NSString *path = [self getFilePath:index];
        return [NSURL fileURLWithPath:path];
    }
    else {
        return [NSURL URLWithString:[self itemAt:index].url];
    }
}

@end

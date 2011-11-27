//
//  CommitsViewController.h
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommitCell.h"
@interface CommitsViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *commits;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *repo;

- (void)searchforCommitsByUser:(NSString*)username forRepo:(NSString*)repository;
- (void)fetchedData:(NSData *)responseData;
@end

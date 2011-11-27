//
//  BAMasterViewController.h
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BADetailViewController;

@interface BAMasterViewController : UITableViewController

@property (strong, nonatomic) BADetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;
@property (strong, nonatomic) NSMutableArray *allKeys;
@property (strong, nonatomic) NSString *username;
- (void)getReposForUser:(NSString *)user;
- (void)fetchedData:(NSData *)responseData;

@end

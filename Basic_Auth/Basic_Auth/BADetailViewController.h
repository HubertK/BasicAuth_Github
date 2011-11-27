//
//  BADetailViewController.h
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginFormViewController.h"

@interface BADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) LoginFormViewController *loginForm;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicReposLabel;
@property (weak, nonatomic) IBOutlet UILabel *folowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

- (IBAction)login:(id)sender;
- (IBAction)tryBasicAuth:(id)sender;
- (void)sendLoginInfo:(NSString*)username andPassword:(NSString*)pass;
- (void)getReposForUser:(NSString *)user;
- (void)fetchedData:(NSData *)responseData;
int encode(unsigned s_len, char *src, unsigned d_len, char *dst);
@end

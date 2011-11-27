//
//  BADetailViewController.m
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import "BADetailViewController.h"

#import "Base64.h"



@interface BADetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation BADetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize loginForm;
@synthesize companyLabel = _companyLabel;
@synthesize locationLabel = _locationLabel;
@synthesize emailLabel = _emailLabel;
@synthesize publicReposLabel = _publicReposLabel;
@synthesize folowingLabel = _folowingLabel;
@synthesize followersLabel = _followersLabel;
@synthesize nameLabel = _nameLabel;
@synthesize avatar = _avatar;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveLoginInformation:) name:@"loginInformationNotification" object:nil];
    
  
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setCompanyLabel:nil];
    [self setLocationLabel:nil];
    [self setEmailLabel:nil];
    [self setPublicReposLabel:nil];
    [self setFolowingLabel:nil];
    [self setFollowersLabel:nil];
    [self setNameLabel:nil];
    [self setAvatar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
- (void)didReceiveLoginInformation:(NSNotification*)notification{
    if ([[notification.userInfo valueForKey:@"cancel"] isEqualToString:@"NO"]) {
        NSString *username = [notification.userInfo valueForKey:@"username"];
        NSString *password = [notification.userInfo valueForKey:@"password"];
        [self sendLoginInfo:username andPassword:password];
        NSLog(@"\nUsername:%@",username);
        NSLog(@"\nPassword:%@",password);
    }
    [UIView animateWithDuration:1.0
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.loginForm.view.alpha = 0.0;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];

      [self.loginForm.view removeFromSuperview];
}




- (IBAction)login:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    loginForm = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginForm.view.frame = CGRectMake(43, 50, 616, 338);
    self.loginForm.view.alpha = 0.0;
    [self.view addSubview:loginForm.view];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.loginForm.view.alpha = 1.0;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         
                     }];
          
}

- (IBAction)tryBasicAuth:(id)sender {
   
}





- (void)sendLoginInfo:(NSString*)username andPassword:(NSString*)pass{
    NSString *URLString = [NSString stringWithFormat:@"https://api.github.com/users/%@",username];
    NSURL *url = [NSURL URLWithString:URLString];  
    NSString *user = username;  
    NSString *password = pass;  
    NSLog(@"\nUsername:%@\nPassword:%@",username,password);
    
    NSError *myError = nil;  
    
    // create a plaintext string in the format username:password  
    NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", user, password];  
    
    // employ the Base64 encoding above to encode the authentication tokens  
    NSString *encodedLoginData = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];  
    
    // create the contents of the header   
    NSString *authHeader = [@"Basic " stringByAppendingFormat:@"%@", encodedLoginData];  
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url  
                                                           cachePolicy: NSURLRequestReloadIgnoringCacheData    
                                                       timeoutInterval: 3];     
    
    // add the header to the request.  Here's the $$$!!!  
    [request addValue:authHeader forHTTPHeaderField:@"Authorization"];  
    
    // perform the reqeust  
    NSURLResponse *response;  
    
    NSData *data = [NSURLConnection    
                    sendSynchronousRequest: request    
                    returningResponse: &response    
                    error: &myError];    
    NSError *error;  
    
    // POW, here's the content of the webserver's response.  
    NSString *result = [NSString stringWithCString:[data bytes] length:[data length]]; 
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data 
                          options:kNilOptions 
                          error:&error];
    NSLog(@"JSON :%@",json);
    if ([json count] > 0) {
        
    self.nameLabel.text = [json valueForKey:@"name"];
    self.emailLabel.text = [json valueForKey:@"email"];
    self.companyLabel.text = [json valueForKey:@"company"];
    self.locationLabel.text = [json valueForKey:@"location"];
    self.followersLabel.text = [[json valueForKey:@"followers"]stringValue];
    self.folowingLabel.text = [[json valueForKey:@"following"]stringValue];
    self.publicReposLabel.text = [[json valueForKey:@"public_repos"]stringValue];
    NSString *avatarURLString = [json valueForKey:@"avatar_url"];
    NSURL *avatarURL = [NSURL URLWithString:avatarURLString];
    NSData *avaatarData = [NSData dataWithContentsOfURL:avatarURL];
    self.avatar.image = [UIImage imageWithData:avaatarData];
//        NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[json valueForKey:@"name"],@"NAME",[json valueForKey:@"email"],@"EMAIL",[json valueForKey:@"company"],@"COMPANY",[json valueForKey:@"location"],@"LOCATION", nil];
        NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:user,@"username", nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"InformationNotification" object:nil userInfo:userInfo];
        }
    
}












@end

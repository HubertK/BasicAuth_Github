//
//  LoginFormViewController.m
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import "LoginFormViewController.h"

@implementation LoginFormViewController
@synthesize userNameField;
@synthesize passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)sendLoginInfo:(id)sender {
    [self postNotification];
}

- (IBAction)cancel:(id)sender {
    NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:self.userNameField.text,@"username",self.passwordField.text,@"password",@"YES",@"cancel", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginInformationNotification" object:nil userInfo:userInfo];
    

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userNameField) {
        [self.passwordField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
           }
    return YES;
}


- (void)postNotification{
    NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:self.userNameField.text,@"username",self.passwordField.text,@"password",@"NO",@"cancel", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginInformationNotification" object:nil userInfo:userInfo];
    
}







@end

//
//  BAMasterViewController.m
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import "BAMasterViewController.h"
#import "CommitsViewController.h"
#import "BADetailViewController.h"

@implementation BAMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize dataDictionary,allKeys,username;
- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (BADetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.dataDictionary = [[NSMutableDictionary alloc]initWithCapacity:10];
    self.allKeys = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetData:) name:@"InformationNotification" object:nil];
}
- (void)didGetData:(NSNotification*)notification{
    if (notification) {
        self.username = [notification.userInfo valueForKey:@"username"];
        [self getReposForUser:[notification.userInfo valueForKey:@"username"]];
    }
}

- (void)viewDidUnload
{
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.dataDictionary count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [[self.dataDictionary allKeys]objectAtIndex:indexPath.section];
    cell.detailTextLabel.text = [self.dataDictionary valueForKey:cell.textLabel.text];
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)getReposForUser:(NSString *)user{
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        NSString *URLString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos",user];
        NSURL *URL = [NSURL URLWithString:URLString];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            [self fetchedData:data];
            
        });
    });
    
    
    
}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData 
                          options:kNilOptions 
                          error:&error];
    if (error) {
        NSLog(@"ERROR:%@",[error localizedDescription]);
    }
    NSLog(@"repos :%@",json);
    for (int i = 0; i < [json count]; i++) {
        NSString *repoName = [[json valueForKey:@"name"]objectAtIndex:i];
        NSString *repoDescription = [[json valueForKey:@"description"]objectAtIndex:i];
        [self.dataDictionary setValue:repoDescription forKey:repoName];
       
    }
    [self.tableView reloadData];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CommitsViewController *controller = [story instantiateViewControllerWithIdentifier:@"commits"];
    [controller setUser:self.username];
   NSString *repo = [[self.dataDictionary allKeys]objectAtIndex:indexPath.section];
    [controller setRepo:repo];
    [self.navigationController pushViewController:controller animated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
























@end

//
//  StartTableViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoviesViewController_iPad.h"
#import "AppDelegate.h"
#import "Movie.h"
#import "MovieDetailViewController.h"



@implementation MoviesViewController_iPad

@synthesize sections,successfulmovies;




-(void)loadView{
    [super loadView];
    charged=0;
    alert = [[UIAlertView alloc] initWithTitle:@"Getting data from server\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    int repeted=0;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    sections = [[NSMutableArray alloc] init];
    successfulmovies = [[NSMutableArray alloc]init];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"successfulmovies"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            successfulmovies = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            successfulmovies = [[NSMutableArray alloc] init];
    }
    
    for(int s=0;s<1;s++) { // 1 sections
        NSMutableArray *section = [[NSMutableArray alloc] init];
        
        repeted=0;
        Movie *aMovie =[[Movie alloc]init];
        Movie *aMovie2 =[[Movie alloc]init];
        for(aMovie in appDelegate.movies){
            Movie *item = [[Movie alloc] init];
            
            for(aMovie2 in successfulmovies){
                if([aMovie.title isEqualToString:aMovie2.title]){
                    repeted=1;
                    break;
                }
            }
            
            if(repeted==1){
                item=aMovie;
                repeted=0;
            }else{
                item.title=@"Locked";
                item.filename = @"locked";
                
            }
            [section addObject:item];
        }
        
        
        
        
        
        [sections addObject:section];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle = [NSString stringWithFormat:@"Have you seen...", section];
    return sectionTitle;
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
    if(charged == 0)
    {
        charged=1;
        int n = [sectionItems count];
        int i=0,i1=0; 
        
        while(i<n){
            int yy = 4 +i1*74;
            int j=0;
            for(j=0; j<4;j++){
                
                if (i>=n) break;
                Movie *item = [sectionItems objectAtIndex:i];
                
                CGRect rect = CGRectMake(40+170*j, 3*yy+23, 100, 150);
                UIButton *button=[[UIButton alloc] initWithFrame:rect];
                [button setFrame:rect];
                
                
                NSString *string=  [NSString stringWithFormat:@"http://www.myhost.nixiweb.com/smallimagesmovies_iPad/%@.png", item.filename];
                
                NSURL *url = [NSURL URLWithString:string]; 
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                UIImage *buttonImageNormal=[UIImage imageWithData:data];
                [button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
                [button setContentMode:UIViewContentModeCenter];
                
                NSString *tagValue = [NSString stringWithFormat:@"%d%d", section+1, i];
                button.tag = [tagValue intValue];
                //NSLog(@"….tag….%d", button.tag);
                
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [hlcell.contentView addSubview:button];
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((170*j), (3*yy)+180,170, 25)];
                label.text = item.title;
                label.textColor = [UIColor blackColor];
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = UITextAlignmentCenter;
                label.font = [UIFont fontWithName:@"ArialMT" size:17]; 
              
                [hlcell.contentView addSubview:label];
                
                i++;
            }
            i1 = i1+1;
        }
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [sections count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *hlCellID = @"hlCellID";
    
    hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    if(hlcell == nil) {
        hlcell =  [[UITableViewCell alloc] 
                   initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
        hlcell.accessoryType = UITableViewCellAccessoryNone;
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    section = indexPath.section;
    
    sectionItems = [sections objectAtIndex:section];
    
    
    
    return hlcell;
    
}

- (IBAction)goToMainMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)buttonPressed:(id)sender {
    int tagId = [sender tag];
    int divNum = 0;
    if(tagId<100)
        divNum=10;
    else 
        divNum=100;
    int section = [sender tag]/divNum;
    section -=1; // we had incremented at tag assigning time 
    int itemId = [sender tag]%divNum;
    
    
    // NSLog(@"…section = %d, item = %d", section, itemId);
    
    
    
	
	NSMutableArray *sectionItems = [sections objectAtIndex:section];
    Movie *item = [sectionItems objectAtIndex:itemId];
	
	
    if(item.title!=@"Locked"){
        mdvController = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailViewController"];
        mdvController.aMovie= item;
        [self.navigationController pushViewController:mdvController animated:YES];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
    
    NSMutableArray *sectionItems = [sections objectAtIndex:indexPath.section];
    int numRows = [sectionItems count]/4;
    return numRows * 230.0;
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
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

//
//  MovieDetailTableViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieDetailViewController.h"
#import"Movie.h"
#import "StorylineViewController.h"
#import "TrailerViewController.h"

@implementation MovieDetailViewController
@synthesize aMovie;


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
    options = [NSArray arrayWithObjects:@"Storyline",@"Trailer",nil];
      
   
    if((aMovie.writer2 == nil)&&(aMovie.writer3 == nil)){
        writers =[NSMutableArray arrayWithObjects:aMovie.writer1,nil];
    }else if((aMovie.writer3 == nil)){
        
       writers =[NSMutableArray arrayWithObjects:aMovie.writer1,aMovie.writer2, nil];
    }else{
         writers =[NSMutableArray arrayWithObjects:aMovie.writer1,aMovie.writer2,aMovie.writer3, nil];
    }
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    switch(section)
	{
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2: 
            return [writers count];
            break;
        case 3:
            return [options count];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
  
	 
	switch(indexPath.section)
	{
		case 0:
           
           

			cell.text = aMovie.title;
			break;
        case 1:
            
            cell.text = aMovie.director;
			break;
        case 2:
            cell.textLabel.text = [writers objectAtIndex:[indexPath row]];
			break;
        case 3:

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [options objectAtIndex:[indexPath row]];
            
			break;
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tblView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionName = nil;
	
	switch(section)
	{
		case 0:
            
			sectionName = @"Title";
			break;
        case 1:
            sectionName = @"Director";
			break;
        case 2:
            if([writers count]>1)
                sectionName= @"Writers";
            else
                sectionName= @"Writer";
			break;
        case 3:
            sectionName= @"More info...";
			break;
		
		
	}
	
	return sectionName;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
   NSLog(@"section: %d", indexPath.section);
    
    if(indexPath.section == 3){
        switch (indexPath.row) {
            case 0:
                slvc = [self.storyboard instantiateViewControllerWithIdentifier:@"StorylineViewController"];
                slvc.storyline= aMovie.storyline;
                [self.navigationController pushViewController:slvc animated:YES];
                

                break;
                

            case 1:
                tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TrailerViewController"];
                tvc.trailer = aMovie.trailer;
                [self.navigationController pushViewController:tvc animated:YES];
                break;
        }
    }

}





- (IBAction)goToMovies:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

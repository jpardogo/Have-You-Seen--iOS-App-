//
//  StartTableViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate,MovieDetailViewController;

@interface MoviesViewController : UIViewController{
    
    AppDelegate *appDelegate;
    NSMutableArray *sections;
    NSMutableArray *successfulmovies;
    MovieDetailViewController *mdvController;
    UIAlertView *alert;
    int section;
    NSMutableArray *sectionItems;
    UITableViewCell *hlcell;
    int charged;
    
   
}


@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSMutableArray *successfulmovies;
- (IBAction)goToMainMenu:(id)sender;

-(IBAction)buttonPressed:(id)sender;
@end

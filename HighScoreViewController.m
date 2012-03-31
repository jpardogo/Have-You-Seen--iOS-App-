//
//  HighScoreViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScoreViewController.h"

@implementation HighScoreViewController
@synthesize labelname;
@synthesize labelpoints;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [defaults objectForKey:@"namerecord"];
    NSNumber *points = [defaults objectForKey:@"highscore"];
    
    labelname.text = name;
    labelpoints.text = [[NSString alloc] initWithFormat:@"%d",points.integerValue];
                          
                          
}


- (void)viewDidUnload
{
    [self setLabelname:nil];
    [self setLabelpoints:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goToMainMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end

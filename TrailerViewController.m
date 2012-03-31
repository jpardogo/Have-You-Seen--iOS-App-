//
//  TrailerViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrailerViewController.h"

@implementation TrailerViewController
@synthesize infoVideo1,trailer;
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
    NSString *stringURL = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@",trailer];
    [self embedYouTubeInWebView:stringURL theWebView:infoVideo1];

}


- (void)viewDidUnload
{

    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [infoVideo1 loadHTMLString:nil baseURL:nil];
}

- (IBAction)goToDetailsMovie:(id)sender {
   
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)embedYouTubeInWebView:(NSString*)url theWebView:(UIWebView *)aWebView {     
    
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    
    NSString* html = [NSString stringWithFormat:embedHTML, url, aWebView.frame.size.width, aWebView.frame.size.height]; 
    
    [aWebView loadHTMLString:html baseURL:nil];
    
    
    
}


@end

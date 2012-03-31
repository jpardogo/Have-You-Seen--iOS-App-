//
//  MovieDetailTableViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie,StorylineViewController,TrailerViewController;
@interface MovieDetailViewController : UIViewController
{
     Movie *aMovie;
    NSArray *options;
    NSMutableArray *writers;
    StorylineViewController *slvc;
    TrailerViewController *tvc;
}
@property (nonatomic, retain) Movie *aMovie;



- (IBAction)goToMovies:(id)sender;



@end

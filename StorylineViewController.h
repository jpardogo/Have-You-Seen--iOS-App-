//
//  StorylineViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorylineViewController : UIViewController
{
    NSString *storyline;
}

@property (nonatomic, retain) NSString *storyline;

@property (strong, nonatomic) IBOutlet UITextView *textViewStoryline;
- (IBAction)goToMovieDetails:(id)sender;
@end

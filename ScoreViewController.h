//
//  ScoreViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController
{
    NSNumber *score;
    NSMutableArray *successfulmovies;
    NSMutableArray *lastsuccessfulmovies;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *imgHighscore;
@property (strong, nonatomic) IBOutlet UILabel *labelScore;
@property (nonatomic,retain) NSNumber *score;
@property (strong ,nonatomic) NSMutableArray *lastsuccessfulmovies;
@property (strong, nonatomic) IBOutlet UILabel *labelRecord;
-(void) promptAlert;
@end

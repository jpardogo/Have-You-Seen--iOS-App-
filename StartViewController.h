//
//  StartViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class AppDelegate,Movie,ScoreViewController;
@interface StartViewController : UIViewController
{
    AVAudioPlayer *audioPlayer;
    AppDelegate *appDelegate;
    Movie *actualMovie;
    Movie *aMovie;
    NSMutableArray *listOfNumbers;
    NSMutableArray *lastsuccessfulmovies;
    int clicks;
    int score;
    int pointsMovie;
    int videoClick;
    int audioClick;
    ScoreViewController *svController;
    UIAlertView *alert;
    CGRect touchRect;
    int numMovie;
   
}
@property (strong, nonatomic) IBOutlet UILabel *labelTitleMoviePoints;

@property (strong, nonatomic) IBOutlet UILabel *labelMaximumScore;

@property (strong, nonatomic) IBOutlet UILabel *labelCountMovies;
@property (strong, nonatomic) IBOutlet UIButton *next2;
@property (strong, nonatomic) IBOutlet UITextView *textViewSentence;
@property (strong, nonatomic) IBOutlet UILabel *labelPointsMovie;
@property (retain, nonatomic) IBOutlet UIWebView *infoVideo1;
@property (strong, nonatomic) IBOutlet UILabel *labelScore;

@property (strong, nonatomic) IBOutlet UIButton *IhaveSeenButton;
@property (strong, nonatomic) IBOutlet UIImageView *imgMovie;
@property (strong, nonatomic) IBOutlet UIButton *imgaudio;
@property (strong, nonatomic) NSMutableArray *lastsuccessfulmovies;
- (IBAction)IhaveSeenButtonClick:(id)sender;
- (IBAction)goToMainMenu:(id)sender;
- (IBAction)nextMovie:(id)sender;
-(void)getEightRandomLessThan;
-(void)embedYouTubeInWebView:(NSString*)url theWebView: (UIWebView *)aWebView;
-(void)waitingDialog;




@end

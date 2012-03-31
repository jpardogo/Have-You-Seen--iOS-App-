//
//  StartViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import "Movie.h"
#import "AlertPrompt.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "ScoreViewController.h"



@implementation StartViewController


@synthesize labelTitleMoviePoints;
@synthesize labelMaximumScore;
@synthesize labelCountMovies;
@synthesize next2;
@synthesize textViewSentence;
@synthesize infoVideo1;
@synthesize labelScore;

@synthesize IhaveSeenButton;
@synthesize imgMovie;
@synthesize imgaudio;
@synthesize labelPointsMovie;
@synthesize lastsuccessfulmovies;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{   [super loadView];
}

- (void)playbackStateDidChange:(NSNotification *)note
{
   //NSLog(@"note.name=%@ state=%d", note.name, [[note.userInfo objectForKey:@"MPAVControllerNewStateParameter"] intValue]);
    
    UIImage *playimage = [UIImage imageNamed:@"play.png"];
    [imgaudio setBackgroundImage:playimage forState:UIControlStateNormal];
    
    int state = [[note.userInfo objectForKey:@"MPAVControllerNewStateParameter"] intValue];
    videoClick++;
    if(state==2 && videoClick==1)
    {
        
       
            pointsMovie = pointsMovie -4;
            labelPointsMovie.text= [NSString stringWithFormat:@"%d",pointsMovie];
        
    }
}


- (IBAction)goToMainMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextMovie:(id)sender {
    
    
     next2.hidden=YES;
    labelPointsMovie.hidden=NO;
    labelTitleMoviePoints.hidden=NO;
    infoVideo1.hidden=YES;
    pointsMovie=10;
    videoClick=0;
     audioClick=0;
    [audioPlayer stop];
    next2.hidden=YES;
    IhaveSeenButton.hidden=NO;
    
    numMovie++;
    labelCountMovies.text=[[NSString alloc] initWithFormat:@"%d / %d",numMovie,[appDelegate.movies count]];
    
    UIImage *playimage = [UIImage imageNamed:@"play.png"];
    [imgaudio setBackgroundImage:playimage forState:UIControlStateNormal];
    
    if(clicks>([appDelegate.movies count] -1))
    {
        svController = [self.storyboard instantiateViewControllerWithIdentifier:@"scoreViewController"];
        NSNumber *sendscore =[[NSNumber alloc] initWithInt:score];
        svController.score=sendscore;
        svController.lastsuccessfulmovies = [[NSMutableArray alloc] initWithArray:lastsuccessfulmovies];
        [self.navigationController pushViewController:svController animated:YES];    
    }
    else
    {
       
        
        imgMovie.image= [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"locked" ofType:@"png"]];
      
        labelPointsMovie.text=[NSString stringWithFormat:@"%d",pointsMovie];
        
        labelScore.text= [NSString stringWithFormat:@"%d",score];
        int num = [[listOfNumbers objectAtIndex:clicks]intValue];
        for(aMovie in appDelegate.movies){
           
            if(aMovie.movieID == num)
            {
                textViewSentence.text=aMovie.sentence;
                actualMovie = aMovie;
            }
        }
        NSString *stringURL = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@",actualMovie.video];
        
        [self embedYouTubeInWebView:stringURL theWebView:infoVideo1];
    }
    
   
    clicks++;
}

-(void)waitingDialog{
    alert = [UIAlertView alloc];
    alert = [alert initWithTitle:@"Audio Help\nGetting audio from server\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
}
                    

- (IBAction)audioHelp:(id)sender {
   audioClick++;
    
    if([audioPlayer isPlaying]){
        [audioPlayer stop];
        UIImage *playimage = [UIImage imageNamed:@"play.png"];
        [imgaudio setBackgroundImage:playimage forState:UIControlStateNormal];
    }else{
        
       
        UIImage *stopimage = [UIImage imageNamed:@"stop.png"];
        
        [imgaudio setBackgroundImage:stopimage forState:UIControlStateNormal];

        
         self.waitingDialog;
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // Add code here to do background processing
            //
            //
            int ready=0;
             NSString *string= [NSString stringWithFormat:@"http://www.myhost.nixiweb.com/audiomovies/%@.mp3", actualMovie.filename];
             NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
            NSError *error;
            audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
            ready=1;
            dispatch_async( dispatch_get_main_queue(), ^{
                // Add code here to update the UI/send notifications based on the
                // results of the background processing
               
                while(ready==0){
                    NSLog(@"ESPERANDO...");
                }
               
               
                
                audioPlayer.numberOfLoops = 0;
                audioPlayer.volume = 1.0f;
                [audioPlayer setDelegate:self];
                [audioPlayer prepareToPlay];
                
                if (audioPlayer != nil){
                    [audioPlayer play];   
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                    

                }
                    
            });
        });
       
           
   
       
        
   
       
    
        
        if(audioClick==1)
        {
       
            pointsMovie = pointsMovie -3;
            labelPointsMovie.text= [NSString stringWithFormat:@"%d",pointsMovie];
             infoVideo1.hidden=NO;
            
        }
    }
  
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    UIImage *playimage = [UIImage imageNamed:@"play.png"];
    [imgaudio setBackgroundImage:playimage forState:UIControlStateNormal];
}

-(void)getEightRandomLessThan{
    listOfNumbers = [[NSMutableArray alloc] init];
    int count =[appDelegate.movies count];
    for (int i=1 ; i<=count ; ++i) {
        [listOfNumbers addObject:[NSNumber numberWithInt:i]]; // ADD 1 TO GET NUMBERS BETWEEN 1 AND M RATHER THAN 0 and M-1
    }
    count = [listOfNumbers count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
       
        int n = arc4random() % count;
        [listOfNumbers exchangeObjectAtIndex:n withObjectAtIndex:i];
    }
   
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    infoVideo1.hidden=YES;
    score=0;
    pointsMovie = 10;
    videoClick=0;
    audioClick=0;
    numMovie=1;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    labelCountMovies.text=[[NSString alloc] initWithFormat:@"%d / %d",numMovie,[appDelegate.movies count]];
    
    lastsuccessfulmovies = [[NSMutableArray alloc] init];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *points = [defaults objectForKey:@"highscore"];
    labelMaximumScore.text = [[NSString alloc] initWithFormat:@"%d",points.integerValue];
    
    

    labelScore.text= [NSString stringWithFormat:@"%d",score];
    labelPointsMovie.text= [NSString stringWithFormat:@"%d",pointsMovie];
    
    clicks=1;
   
    
    
    UIImage *playimage = [UIImage imageNamed:@"play.png"];
    [imgaudio setBackgroundImage:playimage forState:UIControlStateNormal];
    
     
    
    next2.hidden=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateDidChange:)
                                                 name:@"MPAVControllerPlaybackStateChangedNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioPlayerDidFinishPlaying:successfully:)
                                                 name:@"AVAudioPlayerDidFinishPlayingNotification"
                                               object:nil];
    
    
    self.getEightRandomLessThan;
    
    for(aMovie in appDelegate.movies){
        
        if(aMovie.movieID == [[listOfNumbers objectAtIndex:0]intValue])
        {
            //  labelSentence.text=aMovie.sentence;
            textViewSentence.text=aMovie.sentence;
            actualMovie = aMovie;
            
            
            
        }
    }

    NSString *stringURL = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@",actualMovie.video];
    [self embedYouTubeInWebView:stringURL theWebView:infoVideo1];
    
}







- (void)viewDidUnload
{
    [self setLabelScore:nil];
    [self setLabelPointsMovie:nil];
  
    [self setImgMovie:nil];
    [self setTextViewSentence:nil];
    [self setIhaveSeenButton:nil];
    
   
    [self setInfoVideo1:nil];
    [self setImgaudio:nil];
    [self setNext2:nil];
    [self setLabelCountMovies:nil];
    [self setLabelMaximumScore:nil];
    [self setLabelTitleMoviePoints:nil];
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)IhaveSeenButtonClick:(id)sender {
    
    AlertPrompt *prompt = [AlertPrompt alloc];
    prompt = [prompt initWithTitle:@"Movie title" message:@"\n\n Please, write the movie title" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Okay"];
    [prompt show];
  
}



- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex!=0){
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        NSString *entered = [(AlertPrompt *)alertView enteredText];
      
        NSString *spacetitle = [NSString stringWithFormat:@"%@ ",actualMovie.title];
       if([[actualMovie.title uppercaseString] isEqualToString:[entered uppercaseString]]||
          [[spacetitle uppercaseString] isEqualToString:[entered uppercaseString]])
        //if([actualMovie.title isEqualToString:actualMovie.title])
        {
            
            score=score+pointsMovie;
            labelScore.text=[NSString stringWithFormat:@"%d",score];
            [lastsuccessfulmovies addObject:actualMovie];
            
            
           
            NSString *string=  [NSString stringWithFormat:@"http://www.myhost.nixiweb.com/imagesmovies/%@.png", actualMovie.filename];
            NSURL *url = [NSURL URLWithString:string]; 
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *picture=[UIImage imageWithData:data];
            imgMovie.image= picture;
            UIAlertView *messageCorrect = [[UIAlertView alloc] initWithTitle:@"Correct"
                                                              message:@"Congratulation!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [messageCorrect show];
            next2.hidden=NO;
            IhaveSeenButton.hidden=YES;
            labelPointsMovie.hidden=YES;
            labelTitleMoviePoints.hidden=YES;
            
            
        }else{
            NSLog(@"%@ ",[entered uppercaseString]);
            
            UIAlertView *messageIncorrect = [[UIAlertView alloc] initWithTitle:@"Incorrect"
                                                              message:@"The title of the movie is not the one you wrote"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [messageIncorrect show];        }
    }
    }
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

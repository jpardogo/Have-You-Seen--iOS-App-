//
//  ScoreViewController.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"
#import "Movie.h"
#import "AlertPrompt.h"

@implementation ScoreViewController
@synthesize imgHighscore;
@synthesize labelRecord;
@synthesize labelScore,score,lastsuccessfulmovies;


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
    int repeted=0;
    int newMovies=0;
    imgHighscore.hidden=YES;
    
    labelScore.text =[NSString stringWithFormat:@"%d", score.integerValue];
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"successfulmovies"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            successfulmovies = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else{
            successfulmovies = [[NSMutableArray alloc] init];
          
        }
    }
    
    if([lastsuccessfulmovies count]>0){
        
    
        Movie *aMovieNew = [[Movie alloc] init];
        Movie *aMovieSuccess = [[Movie alloc] init];
     
        if([successfulmovies count]==0){
            for(aMovieNew in lastsuccessfulmovies)
            {
                [successfulmovies addObject:aMovieNew];
            
            }
       
            newMovies =1;
        }else{
   
    
       
      
    
            for(aMovieNew in lastsuccessfulmovies){
        
                for(aMovieSuccess in successfulmovies)
                {
                    if([aMovieNew.title isEqualToString:aMovieSuccess.title] ){
                        repeted=1;
                        break;
                    }
            
                }
                if(repeted==0){
                    [successfulmovies addObject:aMovieNew];
                    newMovies =1;
                }
                repeted=0;
            }
        }
    
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:successfulmovies] forKey:@"successfulmovies"];
    
    
    
        if(newMovies==1)
        {
            UIAlertView *messageNewMovies = [[UIAlertView alloc] initWithTitle:@"New movies were Unlocked"
                                                               message:@"Now you are able to check the information of the new movies that you have just found out .To do that, click on my movies button in the main menu."
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
            [messageNewMovies show];
        }
    }
    
    NSNumber *highscore = [currentDefaults objectForKey:@"highscore"];
    if(score.integerValue>highscore.integerValue)
    {
        highscore = score;
        [currentDefaults setObject:highscore forKey:@"highscore"];
        imgHighscore.hidden=NO;
        labelRecord.text=@"New Record!! ";
        
        
        self.promptAlert;
        
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        
        NSString *entered = [(AlertPrompt *)alertView enteredText];
        if ([entered length]>0) {
           NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            [currentDefaults setObject:entered forKey:@"namerecord"];
            
           

        }else{
            
            self.promptAlert;
        }
       
            
    }        
    
}

-(void) promptAlert{
    AlertPrompt *prompt = [AlertPrompt alloc];
    prompt = [prompt initWithTitle:@"New record!!" message:@"\n\n Please, write your name" delegate:self cancelButtonTitle:nil okButtonTitle:@"Okay"];
    [prompt show];

}



- (void)viewDidUnload
{
    [self setLabelScore:nil];
    [self setLabelRecord:nil];
    [self setImgHighscore:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

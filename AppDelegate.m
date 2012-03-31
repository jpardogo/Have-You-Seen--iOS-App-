//
//  AppDelegate.m
//  asd
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLParser.h"
#import "Reachability.h"
#import "ViewController.h"
#import "Reachability.h"

@interface  AppDelegate(private) 

-(void)reachabilityChanged:(NSNotification*)note;

@end
@implementation AppDelegate

@synthesize window = _window;
@synthesize movies; 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    clickSettings=0;
    parse=0;
   
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"successfulmovies"];
    if (dataRepresentingSavedArray == nil)
    {
        NSMutableArray *successfulmovies;
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:successfulmovies] forKey:@"successfulmovies"];
    }
    
    NSNumber *highscore = [currentDefaults objectForKey:@"highscore"];
    if(highscore==nil){
         highscore =[[NSNumber alloc] initWithInt:0];
        [currentDefaults setObject:highscore forKey:@"highscore"];
    }   
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
     
                                               object:nil];
   
    
   Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
     
    [reach startNotifier];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    
   if(clickSettings==1) 
       [alertView1 dismissWithClickedButtonIndex:0 animated:YES];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    
    
    
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.google.com"];
   
    
    if(![reach isReachable] && clickSettings==1){
        alertView1 = [[UIAlertView alloc] initWithTitle:@"Device Data is Turned Off" 
                                               message:@"Turn on device data or use Wi-Fi to access data." 
                                              delegate:self
                                     cancelButtonTitle:nil  
                                     otherButtonTitles:@"Settings", nil];
		[alertView1 show];

    }
   /* reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Block Says Reachable");
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Block Says Unreachable");
        });
    };
    */
    
        
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability *reach = [note object];
    
    if([reach isReachable])
    {
        if(parse==0){
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.myhost.nixiweb.com/Movies.xml"];
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
            //Initialize the delegate.
            XMLParser *parser = [[XMLParser alloc] initXMLParser];
        
            //Set delegate
            [xmlParser setDelegate:parser];
        
            //Start parsing the XML file.
            BOOL success = [xmlParser parse];
        
            if(success){
                parse=1;
                NSLog(@"NO Errors");
            }  
            else
            {
                
                parse=0;
                NSLog(@"Errors Errors Errors");

            }
        }
    }
    else
    {
        if(clickSettings==0){
            alertView1 = [[UIAlertView alloc] initWithTitle:@"Device Data is Turned Off" 
                                                   message:@"Turn on device data or use Wi-Fi to access data." 
                                                             delegate:self
                                                    cancelButtonTitle:nil  
                                                    otherButtonTitles:@"Settings", nil];
            [alertView1 show];
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
        if (buttonIndex == 0)
        {
            float reqSysVer = [@"5.1" floatValue];
            float currSysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(currSysVer>= reqSysVer)
            {
                alertView1 = [[UIAlertView alloc] initWithTitle:@"Device Data is Turned Off" 
                                                       message:@"We are sorry, because the device version is higher than 5.0.1, it is not possible to redirect you to settings.\n Please turn on device data or use Wi-Fi.\nIn order to do this, go to the device main menu and click on:\n Settings -> General -> Network." 
                                                      delegate:self
                                             cancelButtonTitle:nil  
                                                           otherButtonTitles: nil];
                [alertView1 show];

            }else{
                
                NSURL*url=[NSURL URLWithString:@"prefs:root=General&path=Network"];
                [[UIApplication sharedApplication] openURL:url];
               

            }
                        
             clickSettings=1;
           
        }    
}


@end

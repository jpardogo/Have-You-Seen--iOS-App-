//
//  TrailerViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrailerViewController : UIViewController{
    NSString *trailer;
}

@property (retain, nonatomic) IBOutlet UIWebView *infoVideo1;
@property (nonatomic, retain) NSString *trailer;
- (IBAction)goToDetailsMovie:(id)sender;
-(void)embedYouTubeInWebView:(NSString*)url theWebView: (UIWebView *)aWebView;
@end

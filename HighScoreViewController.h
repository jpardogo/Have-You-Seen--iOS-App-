//
//  HighScoreViewController.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelname;
@property (strong, nonatomic) IBOutlet UILabel *labelpoints;
- (IBAction)goToMainMenu:(id)sender;
@end

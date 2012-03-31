//
//  AppDelegate.h
//  asd
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
      NSMutableArray *movies;
    UIAlertView *alertView;
    UIAlertView *alertView1;
    int clickSettings;
    
    int parse;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *movies;

@end
//
//  XMLParser.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "AppDelegate.h"

@interface XMLParser : NSObject{
    
    NSMutableString *currentElementValue;
  
    AppDelegate *appDelegate;
    Movie *aMovie;
}

- (XMLParser *) initXMLParser;


@end

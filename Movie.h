//
//  Movie.h
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject{
    
NSInteger movieID;
NSString *title; //Same name as the Entity Name.
NSString *director; //Same name as the Entity Name.
NSString *filename; //Same name as the Entity Name.
NSString *sentence;
NSString *writer1;
NSString *writer2;
NSString *writer3;
NSString *video;
    NSString *storyline;
    NSString *trailer;
}

@property (nonatomic, readwrite) NSInteger movieID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *director;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) NSString *sentence;
@property (nonatomic, retain) NSString *video;
@property (nonatomic, retain) NSString *writer1;
@property (nonatomic, retain) NSString *writer2;
@property (nonatomic, retain) NSString *writer3;
@property (nonatomic, retain) NSString *storyline;
@property (nonatomic, retain) NSString *trailer;




@end

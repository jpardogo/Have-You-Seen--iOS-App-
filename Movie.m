//
//  Movie.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"

@implementation Movie
@synthesize title, director, filename, movieID,sentence,video,writer1,writer2,writer3,storyline,trailer;

- (id) initWithCoder: (NSCoder *)coder
{
	self = [[Movie alloc] init];
    if (self != nil)
	{
		self.title = [coder decodeObjectForKey:@"title"];
		self.director = [coder decodeObjectForKey:@"author"];
		self.filename = [coder decodeObjectForKey:@"image"];
		self.movieID = [coder decodeIntForKey:@"movieID"];
		self.sentence = [coder decodeObjectForKey:@"sentence"];
		self.video = [coder decodeObjectForKey:@"video"];
        self.writer1 = [coder decodeObjectForKey:@"writer1"];
		self.writer2 = [coder decodeObjectForKey:@"writer2"];
        self.writer3 = [coder decodeObjectForKey:@"writer3"];
        self.storyline = [coder decodeObjectForKey:@"storyline"];
        self.trailer = [coder decodeObjectForKey:@"trailer"];
	}
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject:title forKey:@"title"];
	[coder encodeObject:director forKey:@"author"];
	[coder encodeObject:filename forKey:@"image"];
	[coder encodeInteger:movieID forKey:@"movieID"];
	[coder encodeObject:sentence forKey:@"sentence"];
	[coder encodeObject:video forKey:@"video"];
    [coder encodeObject:writer1 forKey:@"writer1"];
    [coder encodeObject:writer2 forKey:@"writer2"];
    [coder encodeObject:writer3 forKey:@"writer3"];
    [coder encodeObject:storyline forKey:@"storyline"];
    [coder encodeObject:trailer forKey:@"trailer"];
	
    
}
@end

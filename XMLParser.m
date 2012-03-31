//
//  XMLParser.m
//  HaveYouSeen
//
//  Created by Javier Pardo de Santayana Gomez on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

- (XMLParser *) initXMLParser {
    
    self = [super init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"Movies"]) {
        //Initialize the array.
        appDelegate.movies = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"Movie"]) {
        
        //Initialize the book.
        aMovie = [[Movie alloc] init];
        
        //Extract the attribute here.
        aMovie.movieID = [[attributeDict objectForKey:@"id"] integerValue];
        
        NSLog(@"Reading id value :%i", aMovie.movieID);
    }
    
    NSLog(@"Processing Element: %@", elementName);
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithCapacity:50];
   
    
    [currentElementValue appendString:[string
                                 stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                  whitespaceAndNewlineCharacterSet]]];
    NSLog(@"Processing Value: %@", currentElementValue);
    
}

- (void) parser:(NSXMLParser *) parser
foundIgnorableWhitespace:(NSString *) whitespaceString
{
     
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"Movies"])
        return;
    
    //There is nothing to do if we encounter the Books element here.
    //If we encounter the Book element howevere, we want to add the book object to the array
    // and release the object.
    if([elementName isEqualToString:@"Movie"]) {
        [appDelegate.movies addObject:aMovie];
        
      
        aMovie = nil;
    }
    else
        [aMovie setValue:currentElementValue forKey:elementName];
    
   
    currentElementValue = nil;
}
@end

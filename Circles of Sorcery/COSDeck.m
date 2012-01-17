//
//  COSDeck.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSDeck.h"
#import "COSDeckView.h"
#import "COSCard.h"
#import "NSMutableArray+Shuffle.h"

@implementation COSDeck
@synthesize cards, deckView;

- (void) dealloc {
  [cards release];
  [super dealloc];
}


NSString *readLineAsNSString(FILE *file) {
  char buffer[4096];
  
  // tune this capacity to your liking -- larger buffer sizes will be faster, but
  // use more memory
  NSMutableString *result = [NSMutableString stringWithCapacity:256];
  
  // Read up to 4095 non-newline characters, then read and discard the newline
  int charsRead;
  do
  {
    if(fscanf(file, "%4095[^\n]%n%*c", buffer, &charsRead) == 1)
      [result appendFormat:@"%s", buffer];
    else
      break;
  } while(charsRead == 4095);
  
  return result;
}


+ (NSMutableArray*)readLine:(NSString*)fileLine {
  NSMutableArray* partsData = [[NSMutableArray alloc] init];
  NSMutableArray* phrase = [[NSMutableArray alloc] init];
  
  NSArray* tempPartsData = [fileLine componentsSeparatedByString:@","];
  for (NSString* origPart in tempPartsData) {
    
    NSString* part = [[NSString alloc] initWithString:[origPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    if ([part length] == 0) {
      [part release];
      continue;
    }
    
    if ([part characterAtIndex:0] == '"' && [part characterAtIndex:[part length]-1] != '"') {
      // Starting phrase
      [phrase addObject:[part substringFromIndex:1]];
    } else if ([part characterAtIndex:0] == '"' && [part length] == 1) {
      // Just a lonely quotation mark--a phrase started or ended with a comma
      [phrase addObject:@""];
      if ([phrase count] == 0) {
        // phrase begins with a comma
      } else {
        // phrase ends with a comma
        [partsData addObject:[phrase componentsJoinedByString:@","]];
        [phrase removeAllObjects];
      }
    } else if ([part characterAtIndex:0] == '"' && [part characterAtIndex:[part length]-1] == '"') {
      // Complete quoted phrase
      NSRange inner;
      inner.location = 1;
      inner.length = [part length] - 2;
      [partsData addObject:[part substringWithRange:inner]];
    } else if ([part characterAtIndex:[part length]-1] == '"') {
      // Ending phrase
      [phrase addObject:[part substringToIndex:[part length]-1]];
      [partsData addObject:[phrase componentsJoinedByString:@","]];
      [phrase removeAllObjects];
    } else if ([phrase count] > 0) {
      // Continuing phrase
      [phrase addObject:part];
    } else {
      // Complete phrase
      [partsData addObject:part];
    }
    
    [part release];
  }
  
  [phrase removeAllObjects];
  [phrase release];
  
  return [partsData autorelease];
}


- (id) initForFilename:(NSString*)filename player:(COSPlayer*)player game:(COSGame*)game {
  self = [super init];
  NSString* fullPath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
  
  // read everything from text
  NSString* fileContents = 
  [NSString stringWithContentsOfFile:fullPath 
                            encoding:NSUTF8StringEncoding error:nil];
  
  // first, separate by new line
  NSArray* allLinedStrings = 
  [fileContents componentsSeparatedByCharactersInSet:
   [NSCharacterSet newlineCharacterSet]];
  
  cards = [[NSMutableArray alloc]init];
  for(NSString *cardName in allLinedStrings) {
    if ([cardName isEqualToString:@""]) {
      continue;
    }
    COSCard *card = [[[COSCard alloc]initWithName:cardName player:player game:game]autorelease];
    [cards addObject:card];
  }

  [cards shuffle];

  return self;  
}


- (void) drawCard {
  if ([cards count] == 0) {
    return;
  }
  COSCard *card = [cards lastObject];
  [deckView drawCard:card];
  NSLog(@"Drawing cards %@ from deckView %@", card, deckView);
  [cards removeLastObject];
}


- (void) searchForCardsNamed:(NSArray*)cardNames {
}

@end

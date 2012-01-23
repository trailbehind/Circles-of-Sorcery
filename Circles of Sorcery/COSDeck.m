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
#import "COSPlayer.h"
#import "COSPlayerArea.h"

@implementation COSDeck
@synthesize cards, deckView;

- (void) dealloc {
  [cards release];
  [super dealloc];
}


- (id) initForFilename:(NSString*)filename player:(COSPlayer*)player game:(COSGame*)game {
  self = [super init];
  
  // read everything from text
  NSString* fileContents = 
  [NSString stringWithContentsOfFile:filename 
                            encoding:NSUTF8StringEncoding error:nil];
  
  // first, separate by new line
  NSArray* allLinedStrings = 
  [fileContents componentsSeparatedByCharactersInSet:
   [NSCharacterSet newlineCharacterSet]];
  NSLog(@"The lined array is %@", allLinedStrings);
  cards = [[NSMutableArray alloc]init];
  for(NSString *cardName in allLinedStrings) {
    if ([cardName isEqualToString:@""]) {
      continue;
    }
    COSCard *card = [[[COSCard alloc]initWithName:cardName player:player game:game]autorelease];
    [cards addObject:card];
  }

  [cards shuffle];
  self.deckView = player.playerArea.deckView;
  NSLog(@"after initin, count is %d", [cards count]);

  return self;  
}


- (void) drawFarmer {
  if ([cards count] == 0) {
    return;
  }
  
  COSCard *farmCard;
  for (COSCard *card in cards) {
    if ([card.name isEqualToString:@"Farmer"]) {
      farmCard = card;
    }
  }
  [deckView drawCard:farmCard];
  [cards removeObject:farmCard];
}


- (void) drawCard {
  NSLog(@"When drawing, count is %d", [cards count]);
  if ([cards count] == 0) {
    return;
  }
  COSCard *card = [cards lastObject];
  [deckView drawCard:card];
  NSLog(@"Drawing from deckView %@", deckView);
  [cards removeLastObject];
}


- (void) searchForCardsNamed:(NSArray*)cardNames {
}

@end

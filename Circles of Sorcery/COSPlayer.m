//
//  COSPlayer.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSPlayer.h"
#import "COSCard.h"
#import "COSDeck.h"
#import "NSMutableArray+Shuffle.h"


@implementation COSPlayer
@synthesize gold, rewardPoints, handContainer, cardsInPlay, deck, discardPile, game;


- (void) dealloc {
  [game release];
  [cardsInPlay release];
  [handContainer release];
  [deck release];
  [deckName release];
  [super dealloc];
}


- (void) drawCards:(int)numberOfCards {
  for (int x=0;x<numberOfCards;x++) {
    [deck drawCard];
  }
}

- (void) drawHand {
  [self drawCards:5];
}


- (int) selectGoldAmountWithIncrement:(int)increment {
  // show gold selector
  int amount = 10;
  self.gold -= amount;
  return amount;
}


- (void) gainResourceNamed:(NSString*)resourceName amount:(int)amount {
  if ([resourceName isEqualToString:@"GOLD"]) {
    self.gold += amount;
  }
  if ([resourceName isEqualToString:@"CARDS"]) {
    [self drawCards:amount];
  }
}


- (id) initWithDeck:(NSString*)d game:(COSGame*)g {
  self = [super init];
  game = [g retain];
  deckName = [d retain];
  gold = 0;
  rewardPoints = 0;
  self.cardsInPlay = [NSMutableArray array];
  deck = [[COSDeck alloc] initForFilename:deckName player:self game:game];  
  return self;
}


@end

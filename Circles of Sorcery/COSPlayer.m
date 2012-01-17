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
#import "COSHandContainer.h"
#import "COSDiscardPileView.h"
#import "NSMutableArray+Shuffle.h"


@implementation COSPlayer
@synthesize gold, rewardPoints, handContainer, cardsInPlay, deck, discardPile, game;
@synthesize playerArea;


- (void) dealloc {
  [game release];
  [cardsInPlay release];
  [handContainer release];
  [deck release];
  [deckName release];
  [playerArea release];
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


- (void) beginTurn {
  for (COSCard *card in cardsInPlay) {
    [card highlightIfActivatable];
    [card activateIfAuto];
  }
  
}

- (void) doEndOfTurnEffects {

  NSLog(@"looping over cards in play");
  NSArray *cardInPlayClone = [[cardsInPlay copy]autorelease];
  for (COSCard *c in cardInPlayClone) {
    NSLog(@"The card is %@", c.name);
    if ([c.actions count] == 0) {
      NSLog(@"no actions, continuing");
      continue;
    }
    NSLog(@"The action is %@", [c.actions objectAtIndex:0]);
    if ([[[[c.actions objectAtIndex:0]allKeys]objectAtIndex:0]isEqualToString:@"END_TURN"]) {
      [c activateForEvent:@"END_TURN"];
    }
  }
  NSLog(@"after card loop");
  
  
  [self beginTurn];

}


- (id) initWithDeck:(NSString*)d game:(COSGame*)g {
  self = [super init];
  game = [g retain];
  deckName = [d retain];
  gold = 0;
  rewardPoints = 0;
  self.cardsInPlay = [NSMutableArray array];
  COSHandContainer *handContainer = [[[COSHandContainer alloc]initWithFrame:CGRectZero]autorelease];
  self.handContainer = handContainer;
  
  COSDiscardPileView *discard = [[[COSDiscardPileView alloc]initWithFrame:CGRectZero]autorelease];
   self.discardPile = discard;
  
  deck = [[COSDeck alloc] initForFilename:deckName player:self game:game];  
  return self;
}


@end

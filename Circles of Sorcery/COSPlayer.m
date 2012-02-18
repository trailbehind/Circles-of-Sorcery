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
#import "COSEffect.h"
#import "COSConvertWidget.h"
#import "COSPlayerArea.h"
#import "COSGame.h"
#import "COSScoreKeeper.h"
#import "COSConstants.h"

@implementation COSPlayer
@synthesize gold, rewardPoints, handContainer, cardsInPlay, deck, discardPile, game;
@synthesize playerArea, activeEffects, effectWidgets, deckName, scoreKeeper, activeWorker;


- (void) dealloc {
  [game release];
  [cardsInPlay release];
  [handContainer release];
  [deck release];
  [deckName release];
  [playerArea release];
  [effectWidgets release];
  [scoreKeeper release];
  [activeWorker release];
  [super dealloc];
}


- (void) drawCards:(int)numberOfCards keepScore:(BOOL)keepScore {
  if (keepScore) [scoreKeeper addScore:numberOfCards forThing:@"cards"];
  for (int x=0;x<numberOfCards;x++) {
    [deck drawCard];
  }
}


- (void) drawHand {
  [self drawCards:4 keepScore:NO];
  COSCard *farmerCard = nil;
  for (COSCard *card in handContainer.cards) {
    if ([card.name isEqualToString:@"Farmer"]) {
      farmerCard = card;
    }
  }
  if (farmerCard) {
    [self drawCards:1 keepScore:NO];
  } else {
    [deck drawFarmer];
  }
}


- (int) selectGoldAmountWithIncrement:(int)increment {
  // show gold selector
  int amount = 10;
  self.gold -= amount;
  return amount;
}


- (void) gainResourceNamed:(NSString*)resourceName amount:(int)amount {
  if ([resourceName isEqualToString:@"GET_GOLD"]) {
    self.gold += amount;
  }
  if ([resourceName isEqualToString:@"DRAW_CARD"]) {
    [self drawCards:amount keepScore:YES];
  }
}


- (void) beginTurn {
  for (COSCard *card in cardsInPlay) {
    [card highlightIfActivatable];
    card.resourceToProduce = @"GET_GOLD";
    card.resourceModifier = 1;
  }
  [self drawCards:1 keepScore:NO];
}


- (void) doEndOfTurnEffects:(UIButton*)button {
  
  NSArray *cardInPlayClone = [[cardsInPlay copy]autorelease];
  
  // do all unequipped workers
  for (COSCard *card in cardInPlayClone) {
    if ([card isActivatableForParameter:@"IF_UNEQUIPPED"]
        && [card.buildings count] == 0) {
      [card activateForEvent:@"IF_UNEQUIPPED"];
    }
  }

  // do all equipped buildings
  for (COSCard *card in cardInPlayClone) {
    if ([card isActivatableForParameter:@"EQUIP_WORKER"]
         && [card isFullyStaffed]) {
      [card activateForEvent:@"EQUIP_WORKER"];
    }
  }

  // do all begin end of turn effects
  for (COSCard *card in cardInPlayClone) {
    if ([card isActivatableForParameter:@"BEGIN_END_TURN"]) {
      [card activateForEvent:@"BEGIN_END_TURN"];
    }
  }
  
  for (COSEffect *effect in activeEffects) {
    [effect activate:self];
  }
  [activeEffects removeAllObjects];
  
  
  // do any end of turn effects
  for (COSCard *c in cardInPlayClone) {
    if ([c isActivatableForParameter:@"END_TURN"]) {
      [c activateForEvent:@"END_TURN"];
    }
  }
  
  
  for (COSConvertWidget *c in effectWidgets) {
    [playerArea removeWidget:c];
  }
  [self.effectWidgets removeAllObjects];
  
  
  [scoreKeeper endTurn];
  
  if (scoreKeeper.turnIndex == NUMBER_OF_TURNS) {
    button.enabled = NO;
  } else {
    [playerArea.turnCounter incrementCounter];
  }
  // next turn
  [self beginTurn];
}


- (void) setDeckForPath:(NSString*)path {
  self.deckName = path;
  self.deck = [[[COSDeck alloc] initForFilename:deckName player:self game:game]autorelease];  
}


- (id) initWithDeck:(NSString*)d game:(COSGame*)g {
  self = [super init];
  game = [g retain];
  gold = 0;
  rewardPoints = 0;
 
  self.activeEffects = [NSMutableArray array];
  self.effectWidgets = [NSMutableArray array];
  self.cardsInPlay = [NSMutableArray array];
  COSHandContainer *hc = [[[COSHandContainer alloc]initWithFrame:CGRectZero]autorelease];
  self.handContainer = hc;
  
  COSDiscardPileView *discard = [[[COSDiscardPileView alloc]initWithFrame:CGRectZero]autorelease];
  self.discardPile = discard;
  
  [self setDeckForPath:d];
  
  scoreKeeper = [[COSScoreKeeper alloc]initWithPlayer:self];
  [scoreKeeper addThingToTrack:@"gold"];
  [scoreKeeper addThingToTrack:@"reward"];
  [scoreKeeper addThingToTrack:@"cards"];

  return self;
}


- (void) addCounterForResourcesToGain:(NSString*)resourceName 
                        payGoldAmount:(int)goldAmount
                    forResourceAmount:(int)resourceAmount {
  COSConvertWidget *w = [[[COSConvertWidget alloc] initForResourcesToGive:@"GET_GOLD"
                                                            resourceToGet:resourceName 
                                                                payAmount:goldAmount
                                                        forResourceAmount:resourceAmount
                                                                   player:self]autorelease];
  [playerArea addWidget:w];
  [self.effectWidgets addObject:w];
  
}


- (BOOL) gainGold:(int)amount {
  self.gold += amount;
  if (amount > 0) {
    [scoreKeeper addScore:amount forThing:@"gold"];
  }
  for (int x=0;x<abs(amount);x++) {
    if (amount <0) {
      [playerArea.goldCounter decrementCounter];      
    } else {
      [playerArea.goldCounter incrementCounter];
      
    }
  }
  
  if (self.gold < 0) {
    self.gold = 0;
    playerArea.goldCounter.counterValue = 1;
    [playerArea.goldCounter decrementCounter];
    return NO;
  }
  return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0: {
			break;
		}
		case 1: 
      [game makeNewGame];
			break;
		default:
			break;
	}	
}



- (void) gainReward:(int)amount {
  [scoreKeeper addScore:amount forThing:@"reward"];
  for (int x=0;x<abs(amount);x++) {
    self.rewardPoints++;
    [playerArea.rewardCounter incrementCounter];
    //if (rewardPoints == 10) {
    //  UIAlertView *av = [[[UIAlertView alloc]initWithTitle:@"YOU WIN!" message:@"You got 10 reward points, so you win. Congrats!" delegate:self cancelButtonTitle:@"Keep Playing" otherButtonTitles:@"New Game", nil]autorelease];
    //  [av show];
    // }
  }
}


@end

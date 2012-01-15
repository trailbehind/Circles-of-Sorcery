//
//  COSCard.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSCard.h"
#import "COSConstants.h"
#import "COSCardView.h"
#import "COSPlayer.h"
#import "COSHandContainer.h"
#import "COSDeckView.h"
#import "COSGame.h"
#import "COSCardRegistry.h"

#define DEFAULT_RESOURCE_TO_PRODUCE @"GOLD"

@implementation COSCard
@synthesize name, type, cost, reward, actions, player, resourceToProduce, cardView;


- (void) dealloc {
  [name release];
  [type release];
  [actions release];
  [resourceToProduce release];
  [player release];
  [cardView release];
  [super dealloc];
}


- (id)initWithName:(NSString*)n player:(COSPlayer*)p game:(COSGame*)g {
    self = [super init];
    if (self) {
      player = [p retain];
      self.name = n;
      self.resourceToProduce = DEFAULT_RESOURCE_TO_PRODUCE;
      NSLog(@"The name is %@", [NSString stringWithFormat:@"%@.",name]);
      NSDictionary *cardInfo = [g.cardRegistry.cardIndex objectForKey:name];
      self.type = [cardInfo objectForKey:@"type"];
      self.actions = [cardInfo objectForKey:@"actions"];
      self.cost = [[cardInfo objectForKey:@"cost"]intValue];
      self.reward = [[cardInfo objectForKey:@"reward"]intValue];
      cardView = [[COSCardView alloc]initWithCard:self];
    }
    return self;
}


// add to the player's gold pile
- (CardResult) giveGold:(int)amount {
  player.gold += amount;
  return CONTINUE_ACTIONS;
}


// add to the player's hand
- (CardResult) drawCards:(int)numberOfCards {
  [player drawCards:numberOfCards];
  return CONTINUE_ACTIONS;
}


- (void) sendToDiscard {
  [self.player.discardPile addCard:self];
}


// let a player choose what to discard from the player's hand
- (CardResult) discardCards:(int)numberOfCards {
  NSArray *cards = [player.handContainer chooseCardsToDicard:numberOfCards];
  for (COSCard *card in cards) {
    [card sendToDiscard];
  }
  return CONTINUE_ACTIONS;
}


// check if a card is in play
- (CardResult) testForCard:(NSString*)cardName {
  for (COSCard *card in player.cardsInPlay) {
    if ([card.name isEqualToString:cardName]) {
      return CONTINUE_ACTIONS;
    }
  }
  return END_ACTIONS;
}


// register for resource production event
// when it happens, override resource production
- (CardResult) searchDeckForCardsNamed:(NSArray*)cardNames 
                               putInto:(NSString*)putInto {
  NSArray *cards = [player.deck searchForCardsNamed:cardNames];
  if ([putInto isEqualToString:@"INTO_HAND"]) {
    [cards count];
  } else if ([putInto isEqualToString:@"INTO_PLAY"]) {
  }
  return CONTINUE_ACTIONS;
}


// register for resource production event
// when it happens, override resource production
- (CardResult) replaceGoldFromResourcesNamed:(NSString*)resourceSource
                             goldToReplace:(int)goldQuantity
                         forResourcesNamed:(NSString*)resourcesToGain
                             resourcesToGain:(int)resourcesToGainQuantity {
  for (COSCard *card in player.cardsInPlay) {
    card.resourceToProduce = @"Card";
  }
  return CONTINUE_ACTIONS;
}


// exchange gold for the resource to gain
- (CardResult) changeGold:(int)amount
        forResourcesNamed:(NSString*)resourcesToGain
         resourcesToGain:(int)resourcesToGainQuantity {  
  int goldToPay = [player selectGoldAmountWithIncrement:amount];
  [player gainResourceNamed:resourcesToGain amount:goldToPay/amount*resourcesToGainQuantity];
  return CONTINUE_ACTIONS;
}


// put this in discard
- (CardResult) sacrifice {
  [[self.player cardsInPlay]removeObject:self];
  [self sendToDiscard];
  return CONTINUE_ACTIONS;
}


// loop through cards in play and count them
- (int) countCardsInPlayNamed:(NSString*)cardName {
  int count = 0;
  for (COSCard *card in player.cardsInPlay) {
    if ([card.name isEqualToString:cardName]) {
      count++;
    }
  }
  return count;  
}


// copy the named card the specificed number of times
// and put those cards in play
- (CardResult) copyCardNamed:(NSString*)cardName
                     times:(int)times {
  return CONTINUE_ACTIONS;
}


// this is to let chickens work in this scheme
// is this bad code?
- (CardResult) cancelOtherActionsThisTurnFrom:(NSString*)cardName {
  for (COSCard *card in player.cardsInPlay) {
  }
  // register cards not to act anymore this turn
  return CONTINUE_ACTIONS;
}


- (CardResult) doActionForName:(NSString*)actionName 
                    parameters:(NSArray*)parameters lastResult:(int)lastResult {
  if ([actionName isEqualToString:@"SACRIFICE"]) {
    return [self sacrifice];
  }
  if ([actionName isEqualToString:@"DRAW_CARD"]) {
    return [self drawCards:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"DISCARD_CARD"]) {
    return [self discardCards:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"GOLD"]) {
    return [self giveGold:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"TEST_FOR_CARD"]) {
    return [self testForCard:[parameters objectAtIndex:0]];
  }
  if ([actionName isEqualToString:@"SEARCH_DECK"]) {
    return [self searchDeckForCardsNamed:[parameters objectAtIndex:0]
                                 putInto:[parameters objectAtIndex:1]];
  }
  if ([actionName isEqualToString:@"REPLACE_GOLD_PRODUCTION"]) {
    return [self replaceGoldFromResourcesNamed:[parameters objectAtIndex:0]
                                 goldToReplace:[[parameters objectAtIndex:1]intValue]
                                 forResourcesNamed:[parameters objectAtIndex:2]
                                 resourcesToGain:[[parameters objectAtIndex:3]intValue]
            ];
  }
  if ([actionName isEqualToString:@"CHANGE_GOLD"]) {
    return [self changeGold:[[parameters objectAtIndex:0]intValue]
          forResourcesNamed:[parameters objectAtIndex:1]
            resourcesToGain:[[parameters objectAtIndex:2]intValue]
           ];
  }
  if ([actionName isEqualToString:@"COUNT_CARD"]) {
    return [self countCardsInPlayNamed:[parameters objectAtIndex:0]];
  }
  if ([actionName isEqualToString:@"COPY"]) {
    return [self copyCardNamed:self.name 
                         times:lastResult * [[parameters objectAtIndex:0]floatValue]];
  }
  if ([actionName isEqualToString:@"CANCEL"]) {
    return [self cancelOtherActionsThisTurnFrom:[parameters objectAtIndex:0]];
  }
  return CONTINUE_ACTIONS;
}


- (NSString*)makeTextForAction:(NSString*)actionName 
                    parameters:(NSArray*)parameters 
               numberOfActions:(int)numberOfActions
              numberInSequence:(int)numberInSequence {
  
  NSString *phrase = [[[player.game cardRegistry]actionTranslations]objectForKey:actionName];
  if (numberInSequence == numberOfActions-1) {
    phrase = [phrase stringByAppendingString:@"."];
  }
  return phrase;
}


- (NSString*) displayText {
  NSString *displayText = @"";
  int count = 0;
  for (NSDictionary *action in self.actions) {
    NSString *actionName = [[action allKeys]objectAtIndex:0];
    NSArray *actionParameters = [action objectForKey:actionName];
    NSString *token = [self makeTextForAction:actionName 
                                   parameters:actionParameters
                              numberOfActions:[self.actions count]
                             numberInSequence:count];
    if (token) {
      for (NSObject *obj in actionParameters) {
        NSRange range = [token rangeOfString:@"%s"];
        if (range.location == NSNotFound) {
          continue;
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
          obj = [NSString stringWithFormat:@"%d", [obj intValue]];
        } else if ([obj isKindOfClass:[NSArray class]]) {
          continue;
        }
        token = [token stringByReplacingCharactersInRange:range withString:obj];
      }
      displayText = [displayText stringByAppendingString:token];
    }
    count++;
  }
  
  return displayText;
  
}


- (void) activateForEvent:(NSString*)eventName {
  
  BOOL foundEvent = NO;
  for (NSDictionary *action in actions) {
    if( [[[action allKeys]objectAtIndex:0]isEqualToString:eventName]) {
      foundEvent = YES;
      break;
    }
  }
  if (!foundEvent) {
    return;
  }
  
  int result;
  for (NSDictionary *action in self.actions) {
    NSString *actionName = [[action allKeys]objectAtIndex:0];
    NSArray *actionParameters = [action objectForKey:actionName];
    result = [self doActionForName:actionName 
                        parameters:actionParameters 
                        lastResult:result];
    if (result == END_ACTIONS) {
      break;
    }
  }
  
}

@end

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
#import "COSDeck.h"
#import "COSPlayerArea.h"
#import "COSPlusMinusCounter.h"
#import "COSEffect.h"

#define DEFAULT_RESOURCE_TO_PRODUCE @"GET_GOLD"

@implementation COSCard
@synthesize name, type, cost, reward, actions, player, resourceToProduce, cardView, resourceModifier, subtype;


- (void) dealloc {
  [name release];
  [subtype release];
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
      NSDictionary *cardInfo = [g.cardRegistry.cardIndex objectForKey:name];
      self.type = [cardInfo objectForKey:@"type"];
      self.subtype = [cardInfo objectForKey:@"subtype"];
      self.actions = [cardInfo objectForKey:@"actions"];
      self.cost = [[cardInfo objectForKey:@"cost"]intValue];
      self.reward = [[cardInfo objectForKey:@"reward"]intValue];
      cardView = [[COSCardView alloc]initWithCard:self];
      cardView.handContainer = player.handContainer;
      cardView.discardPile = player.discardPile;
      resourceModifier = 1;
    }
    return self;
}


// add to the player's hand
- (CardResult) drawCards:(int)numberOfCards {
  [player drawCards:numberOfCards keepScore:YES];
  return CONTINUE_ACTIONS;
}


// add to the player's gold pile
- (CardResult) giveReward:(int)amount {  
  [player gainReward:amount];
  return CONTINUE_ACTIONS;
}


// add to the player's gold pile
- (CardResult) giveGold:(int)amount {  
  amount *= self.resourceModifier;
  
  if ([self.resourceToProduce isEqualToString:@"DRAW_CARD"]) {
    self.resourceToProduce = @"GET_GOLD";
    [self drawCards:amount];
    return CONTINUE_ACTIONS;
  }
  [player gainGold:amount];
  return CONTINUE_ACTIONS;
    
}


- (void) sendToDiscard {
  [self.cardView.handContainer.cards removeObject:self];
  [self.player.discardPile addCard:self];
}


// let a player choose what to discard from the player's hand
- (CardResult) discardCards:(int)numberOfCards {
  NSArray *cards = [player.handContainer chooseCardsToDicard:numberOfCards];
  for (COSCard *card in cards) {
    [card sendToDiscard];
  }
  [self.cardView.handContainer layoutCards];
  return CONTINUE_ACTIONS;
}


// check if a card is in play
- (CardResult) testForCard:(NSString*)cardName {
  for (COSCard *card in player.cardsInPlay) {
    if ([card.name isEqualToString:cardName]) {
      return YES_AND_CONTINUE;
    }
  }
  return NO_AND_CONTINUE;
}


// register for resource production event
// when it happens, override resource production
- (CardResult) searchDeckForCardsNamed:(NSArray*)cardNames 
                               putInto:(NSString*)putInto {
  //NSArray *cards = [player.deck searchForCardsNamed:cardNames];
  NSString *cardName = [cardNames objectAtIndex:0];
  COSCard *cardToTransfer = nil;
  for (COSCard *c in player.deck.cards) {
    if ([c.name isEqualToString:cardName]) {
      cardToTransfer = c;
      break;
    }
    
  }
  if (!cardToTransfer) {
    return CONTINUE_ACTIONS;
  }
  [player.deck.cards removeObject:cardToTransfer];
  
  // could lok at INTO_HAND 
  [player.handContainer addCard:cardToTransfer];
  if ([putInto isEqualToString:@"INTO_PLAY"]) {
    [player.handContainer playCard:cardToTransfer];
  }
  return CONTINUE_ACTIONS;
}


// register for resource production event
// when it happens, override resource production
- (CardResult) replaceGoldFromResourcesNamed:(NSString*)resourceSource
                             goldToReplace:(int)goldQuantity
                         forResourcesNamed:(NSString*)resourcesToGain
                             resourcesToGain:(int)resourcesToGainQuantity {

  COSEffect *effect = [[[COSEffect alloc]initForResourcesToGive:resourceSource
                                                      payAmount:goldQuantity
                                                  resourceToGet:resourcesToGain
                                              forResourceAmount:resourcesToGainQuantity]autorelease];
  [player.activeEffects addObject:effect];
  
  return CONTINUE_ACTIONS;
}


// exchange gold for the resource to gain
- (CardResult) changeGold:(int)amount
        forResourcesNamed:(NSString*)resourcesToGain
         resourcesToGain:(int)resourcesToGainQuantity {  
  //int goldToPay = [player selectGoldAmountWithIncrement:amount];
  //[player gainResourceNamed:resourcesToGain amount:goldToPay/amount*resourcesToGainQuantity];
  [player addCounterForResourcesToGain:resourcesToGain 
                         payGoldAmount:amount
                                forResourceAmount:resourcesToGainQuantity];
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
 if ([actionName isEqualToString:@"SACRIFICE_THIS"]) {
    return [self sacrifice];
  }
  if ([actionName isEqualToString:@"DRAW_CARD"]) {
    return [self drawCards:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"DISCARD_CARD"]) {
    return [self discardCards:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"GET_REWARD"]) {
    return [self giveReward:[[parameters objectAtIndex:0]intValue]];
  }
  if ([actionName isEqualToString:@"GET_GOLD"]) {
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
    return [self replaceGoldFromResourcesNamed:[parameters objectAtIndex:2]
                                 goldToReplace:1
                                 forResourcesNamed:[parameters objectAtIndex:3]
                                 resourcesToGain:[[parameters objectAtIndex:4]intValue]
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
  if ([actionName isEqualToString:@"COPY_CARD"]) {
    return [self copyCardNamed:self.name 
                         times:lastResult * [[parameters objectAtIndex:0]floatValue]];
  }
  if ([actionName isEqualToString:@"CANCEL_ACTIONS"]) {
    return [self cancelOtherActionsThisTurnFrom:[parameters objectAtIndex:0]];
  }
  return CONTINUE_ACTIONS;
}


- (NSString*)makeTextForAction:(NSString*)actionName 
                    parameters:(NSArray*)parameters 
               numberOfActions:(int)numberOfActions
              numberInSequence:(int)numberInSequence {
  
  NSString *phrase = [[[player.game cardRegistry]actionTranslations]objectForKey:actionName];
  return phrase;
}


- (NSString*) buildSubstring:(NSArray*)actionParameters index:(int)index {
  NSMutableArray *numbers = [NSMutableArray array];
  for (int x=index+1;x<[actionParameters count];x++) {
    NSObject *param = [actionParameters objectAtIndex:x];
    if (![param isKindOfClass:[NSNumber class]]
        && [(NSString*)param rangeOfString:@"_"].location != NSNotFound) {
      break;
    }
    [numbers addObject:param];
  }
  NSString *token = [player.game.cardRegistry.actionTranslations 
                     objectForKey:[actionParameters objectAtIndex:index]];
  
  if (!token) {
    return @"1111"; 
  }  
  
  for (NSNumber *number in numbers) {
    NSRange range = [token rangeOfString:@"%s"];
    if (range.location == NSNotFound) {
      continue;
    }
    NSString *numString = [NSString stringWithFormat:@"%@", number]; 
    if (numString) {
      token = [token stringByReplacingCharactersInRange:range withString:numString];
    }
  }
  return token;
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
      int count = -1;
      BOOL doingCompound = NO;
      for (NSObject *obj in actionParameters) {
        count++;
        NSRange range = [token rangeOfString:@"%s"];
        if (range.location == NSNotFound) {
          continue;
        }
        if ([obj isKindOfClass:[NSNumber class]] && count == 0) {
          obj = [NSString stringWithFormat:@"%@", obj];
        } else if ([obj isKindOfClass:[NSArray class]]) {
          if ([(NSArray*)obj count] > 0) {
            obj = [(NSArray*)obj objectAtIndex:0];
          }
        } else if ([obj isKindOfClass:[NSString class]]
                   && [(NSString*)obj rangeOfString:@"_"].location != NSNotFound) {
          obj = [self buildSubstring:actionParameters index:count];           
          doingCompound = YES;
        } else if ([obj isKindOfClass:[NSString class]] && !doingCompound) {
          obj = [NSString stringWithFormat:@"%@", obj];
        } else {
          continue;
        }
        token = [(NSString*)token stringByReplacingCharactersInRange:range withString:(NSString*)obj];
          
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
    if (result == NO_AND_CONTINUE) {
      result = CONTINUE_ACTIONS;
      continue;
    }
    result = [self doActionForName:actionName 
                        parameters:actionParameters 
                        lastResult:result];
    if (result == END_ACTIONS) {
      break;
    }
  }
}


- (BOOL) isActivatableForParameter:(NSString*)parameter {
  if ([self.actions count] == 0) {
    return NO;
  }
  if ([[[[self.actions objectAtIndex:0]allKeys]objectAtIndex:0]isEqualToString:parameter]) {
    return YES;
  }  
  return NO;
}


- (void) highlightIfActivatable {
  if ([self isActivatableForParameter:@"ACTIVATED_ABILITY"]) {
    [self.cardView highlightForEffect];
  }
}


- (void) activateEffect {
  if ([actions count] == 0) {
    return;
  }
  [self activateForEvent:[[[self.actions objectAtIndex:0]allKeys]objectAtIndex:0]];
  [self.cardView unhighlight];
}


- (void) playFromHand {
  if([self.type isEqualToString:@"Permanent"]) {
    [self highlightIfActivatable];
    [self.player.cardsInPlay addObject:self];
    [player gainReward:self.reward];
    [player.playerArea addCard:self];
    
    
  } else if([self.type isEqualToString:@"Effect"]) {
    [self.cardView.discardPile discardThenPlay:self];
    [self activateEffect];
  }
}


- (void) activateIfActivatable {
  if ([self isActivatableForParameter:@"ACTIVATED_ABILITY"]) {
    [self activateEffect];
  }
}




@end

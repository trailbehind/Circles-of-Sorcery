//
//  COSEffect.m
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSEffect.h"
#import "COSCard.h"
#import "COSPlayer.h"

@implementation COSEffect


- (void) dealloc {
  [resourceToGive release];
  [resourceToGet release];
  [super dealloc];
}

- (id) initForResourcesToGive:(NSString*)s
                    payAmount:(int)ra
                resourceToGet:(NSString*)gr 
            forResourceAmount:(int)ga {
  self = [super init];
  resourceToGive = [s retain];
  giveAmount = ra;
  resourceToGet = [gr retain];
  getAmount = ga;
  return self;
}


- (void) activateTradeEffect:(COSPlayer*)player {
  // if they can pay enough, do the thing
  if ([player gainGold:-giveAmount]) {
    if ([resourceToGet isEqualToString:@"DRAW_CARD"]) {
      [player drawCards:getAmount];
    } else if ([resourceToGet isEqualToString:@"REWARD_POINT"]) {
      [player gainReward:getAmount];
    }
  }  
}


- (void) activate:(COSPlayer*)player {
   for (COSCard *card in player.cardsInPlay) {
    if ([card.name isEqualToString:resourceToGive]) {      
      if ([resourceToGet isEqualToString:@"DRAW_CARD"]) {
        card.resourceToProduce = @"DRAW_CARD";                     
      } else if ([resourceToGet isEqualToString:@"GET_GOLD"]) {
        card.resourceModifier = getAmount;
      }
    }
  }
}


@end

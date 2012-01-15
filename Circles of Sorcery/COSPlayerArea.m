//
//  COSPlayerArea.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>
#import "COSPlayerArea.h"
#import "COSDeckView.h"
#import "COSCard.h"
#import "COSConstants.h"
#import "COSDiscardPileView.h"
#import "COSHandContainer.h"
#import "COSPlusMinusCounter.h"
#import "COSPlayer.h"
#import "COSDeck.h"

@implementation COSPlayerArea


- (void) dealloc {
  [lifeCounter release];
  [manaCounter release];
  [deckView release];
  [super dealloc];
}


- (void) endTurn {
  // [manaCounter incrementCounter];
  // [deck drawCard];
}


- (void) addDeckView:(COSHandContainer*)handContainer player:(COSPlayer*)player {
  int deckHeight = CARD_HEIGHT * .75;
  int deckWidth = CARD_WIDTH * .75;
  CGRect discardFrame = CGRectMake(self.frame.size.width- deckWidth - PADDING, 
                                   self.frame.size.height- deckHeight - CARD_HEIGHT*2 + 10, 
                                   deckWidth, deckHeight);
  
  COSDiscardPileView *discard = [[[COSDiscardPileView alloc]initWithFrame:discardFrame]autorelease];
  discard.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:discard];
  
  
  
  CGRect deckFrame = CGRectMake(self.frame.size.width-deckWidth - PADDING, 
                                self.frame.size.height-CARD_HEIGHT-20 - deckHeight - PADDING, 
                                deckWidth, deckHeight);
  deckView = [[COSDeckView alloc]initWithFrame:deckFrame 
                                           handContainer:handContainer];
  deckView.deck = player.deck;
  player.deck.deckView = deckView;
  deckView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:deckView];
  
}


- (void) setupPlayArea:(COSPlayer*)player {
  
  
  CGRect lifeCounterFrame = CGRectMake(PADDING, 90, 0, 0);
  lifeCounter = [[COSPlusMinusCounter alloc]initWithFrame:lifeCounterFrame title:@"Gold" startCount:0];
  [self addSubview:lifeCounter];

  CGRect handRegionFrame = CGRectMake(0,
                                      self.frame.size.height-CARD_HEIGHT-20, 
                                      self.frame.size.width, 
                                      CARD_HEIGHT+20);  
  COSHandContainer *handContainer = [[[COSHandContainer alloc]initWithFrame:handRegionFrame]autorelease];
  player.handContainer = handContainer;
  [self addSubview:handContainer];
  
  [self addDeckView:handContainer player:player];

  
  
}


- (id)initWithFrame:(CGRect)frame forPlayer:(COSPlayer*)player {
    self = [super initWithFrame:frame];
    if (self) {
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
      self.backgroundColor = [UIColor colorWithRed:.3 green:.5 blue:.7 alpha:.5];
      [self setupPlayArea:player];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

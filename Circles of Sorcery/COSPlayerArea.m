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
@synthesize player, goldCounter;

- (void) dealloc {
  [goldCounter release];
  [deckView release];
  [player release];
  [super dealloc];
}


- (void) addDeckView:(COSHandContainer*)handContainer player:(COSPlayer*)player {
  int deckHeight = CARD_HEIGHT * .75;
  int deckWidth = CARD_WIDTH * .75;
  CGRect discardFrame = CGRectMake(self.frame.size.width- deckWidth - PADDING, 
                                   self.frame.size.height- deckHeight - CARD_HEIGHT*2 + 10, 
                                   deckWidth, deckHeight);
  
  player.discardPile.frame = discardFrame;
  player.discardPile.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:player.discardPile];
  
  
  
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


- (void) setupPlayArea {
  
  
  CGRect goldCounterFrame = CGRectMake(PADDING, 90, 0, 0);
  goldCounter = [[COSPlusMinusCounter alloc]initWithFrame:goldCounterFrame title:@"Gold" startCount:0];
  [self addSubview:goldCounter];

  CGRect handRegionFrame = CGRectMake(0,
                                      self.frame.size.height-CARD_HEIGHT-20, 
                                      self.frame.size.width, 
                                      CARD_HEIGHT+20);  
  player.handContainer.frame = handRegionFrame;
  [self addSubview:player.handContainer];
  
  [self addDeckView:player.handContainer player:player];

  
  
}


- (id)initWithFrame:(CGRect)frame forPlayer:(COSPlayer*)p {
    self = [super initWithFrame:frame];
    if (self) {
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
      self.backgroundColor = [UIColor colorWithRed:.3 green:.5 blue:.7 alpha:.5];
      player = [p retain];
      player.playerArea = self;
      [self setupPlayArea];
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

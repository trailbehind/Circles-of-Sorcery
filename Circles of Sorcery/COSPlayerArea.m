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
#import "COSCardView.h"

@implementation COSPlayerArea
@synthesize player, goldCounter, rewardCounter, cards, deckView;

- (void) dealloc {
  [rewardCounter release];
  [goldCounter release];
  [deckView release];
  [player release];
  [cards release];
  [widgets release];
  [super dealloc];
}


- (void) addDeckView:(COSHandContainer*)handContainer player:(COSPlayer*)p {
  int deckHeight = CARD_HEIGHT * .75;
  int deckWidth = CARD_WIDTH * .75;
  CGRect discardFrame = CGRectMake(self.frame.size.width- deckWidth - PADDING, 
                                   self.frame.size.height- deckHeight - CARD_HEIGHT*2 + 10, 
                                   deckWidth, deckHeight);
  
  p.discardPile.frame = discardFrame;
  p.discardPile.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:p.discardPile];
  
  
  
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


- (void) clearWidgets {
  
}


- (void) setWidgetFrames {
  int offset = 140;
  for (UIView *widget in widgets) {
    CGRect fr = widget.frame;
    fr.origin.x = PADDING + offset;
    fr.origin.y = PADDING;
    offset += PADDING + fr.size.width;
    widget.frame = fr;
  }
}


- (void) removeWidget:(UIView*)widget {
  [widgets removeObject:widget];
  [widget removeFromSuperview];
  [self setWidgetFrames];
}


- (void) addWidget:(UIView*)widget {
  if (!widgets) {
    widgets = [[NSMutableArray array]retain];
  }
  [widgets addObject:widget];
  [self addSubview:widget];
  [self setWidgetFrames];
}


- (void) setupPlayArea {
  
  CGRect rewardCounterFrame = CGRectMake(0, 0, 100, 50);
  rewardCounter = [[COSPlusMinusCounter alloc]initWithFrame:rewardCounterFrame title:@"Reward" startCount:0 showPlus:NO showMinus:NO];
  [self addWidget:rewardCounter];

  
  CGRect goldCounterFrame = CGRectMake(0, 0, 100, 50);
  goldCounter = [[COSPlusMinusCounter alloc]initWithFrame:goldCounterFrame title:@"Gold" startCount:0 showPlus:NO showMinus:NO];
  [self addWidget:goldCounter];

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
      cards = [[NSMutableArray array]retain];
    }
    return self;
}



- (void) alignCards {
  int farmCount = 0;
  int workerCount = 0;
  int buildingCount = 0;
  int equipmentCount = 0;
  for (COSCard *card in self.cards) {
    CGRect frame = card.cardView.frame;
    if ([card.subtype isEqualToString:@"Farm"]) {
      frame.origin.x = PADDING + farmCount* frame.size.width/2;
      frame.origin.y = 50;      
      farmCount++;      
    } else if ([card.subtype isEqualToString:@"Worker"]) {
      frame.origin.x = PADDING + workerCount * frame.size.width/2;
      frame.origin.y = frame.size.height + PADDING + 50;      
      workerCount++;      
    } else if ([card.subtype isEqualToString:@"Building"]) {
      frame.origin.x = 400 + PADDING + buildingCount * frame.size.width/2;
      frame.origin.y = 50;      
      buildingCount++;      
    } else if ([card.subtype isEqualToString:@"Equipment"] || [card.subtype isEqualToString:@"Animal"]) {
      frame.origin.x = 400 + PADDING + equipmentCount * frame.size.width/2;
      frame.origin.y = frame.size.height + PADDING + 50;      
      equipmentCount++;      
    }
    card.cardView.frame = frame;
  }
}


- (void) removeCard:(COSCard*)card {
  [self.cards removeObject:card];
  [card.cardView removeFromSuperview];
  [self alignCards];
}


- (void) addCard:(COSCard*)card {
  [self.cards addObject:card];
  [self addSubview:card.cardView];
  [self alignCards];
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

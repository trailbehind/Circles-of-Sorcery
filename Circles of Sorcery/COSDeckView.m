//
//  COSDeckView.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSDeckView.h"
#import "COSCard.h"
#import "COSConstants.h"
#import "COSHandContainer.h"
#import "COSPlayer.h"
#import "COSDeck.h"
#import <QuartzCore/QuartzCore.h>
#import "Sound.h"

@implementation COSDeckView
@synthesize deck;

- (void) dealloc {
  [deck retain];
  [handContainer release];
  [firstTouchTime release];
  [super dealloc];
}

- (NSString*) titleText {
  return @"Deck";
}



- (id)initWithFrame:(CGRect)frame handContainer:(COSHandContainer*)hc {
    self = [super initWithFrame:frame];
    if (self) {
      handContainer = [hc retain];
    }
    return self;
}

- (void) addCard:(COSCard*)card {
  [cards addObject:card];
}


- (NSArray*) searchForCardsNamed:(NSArray*)cardNames {
  [self.deck drawCard];
  return [NSArray array];
}


- (void) drawCard:(COSCard*)card {
  // [Sound playRequestSound];
  card.player.handContainer = handContainer;
  [handContainer.cards addObject:card];
  [handContainer layoutCards];
}


- (void) drawHand {
  for (int x=0;x<5;x++) {
    [self.deck drawCard];
  }
}


- (void)clearTouchTime:(NSTimer *)timer {
  [firstTouchTime release];
  firstTouchTime = nil;  
}



 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   return;
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint point = [touch locationInView:self];
  startX = point.x;
  dragging = YES;
  
  if (!firstTouchTime) {
    firstTouchTime = [[NSDate date]retain];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self 
                                   selector:@selector(clearTouchTime:) 
                                   userInfo:nil
                                    repeats:NO];
  } else {
    [self.deck drawCard];
    [firstTouchTime release];
    firstTouchTime = nil;
  }

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  return;
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint point = [touch locationInView:self];  
  if (point.x - startX) {
    // [self showDiscardPile];
  }
  dragging = NO;
  startX = 0;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}



@end

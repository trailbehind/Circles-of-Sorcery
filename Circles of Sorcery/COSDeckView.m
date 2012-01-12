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
#import <QuartzCore/QuartzCore.h>

@implementation COSDeckView


- (void) dealloc {
  [cards release];
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


- (void) drawCard {
  if ([cards count] == 0) {
    return;
  }
  COSCard *card = [cards lastObject];
  card.handContainer = handContainer;
  [handContainer.cards addObject:card];
  [cards removeLastObject];
  [handContainer layoutCards];
}


- (void) drawHand {
  for (int x=0;x<5;x++) {
    [self drawCard];
  }
}


- (void)clearTouchTime:(NSTimer *)timer {
  [firstTouchTime release];
  firstTouchTime = nil;  
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
    [self drawCard];
    [firstTouchTime release];
    firstTouchTime = nil;
  }

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint point = [touch locationInView:self];  
  if (point.x - startX) {
    [self showDiscardPile];
  }
  dragging = NO;
  startX = 0;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}



@end

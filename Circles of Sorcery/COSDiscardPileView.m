//
//  COSDiscardPileView.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSDiscardPileView.h"
#import "COSConstants.h"
#import "COSCard.h"
#import "COSDiscardContainer.h"
#import <QuartzCore/QuartzCore.h>

@implementation COSDiscardPileView
@synthesize cards, discardContainer;

- (void) dealloc {
  [cards release];
  [firstTouchTime release];
  [discardContainer release];
  [super dealloc];
}


- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    cards = [[NSMutableArray array]retain];
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.borderColor = CARD_BORDER_COLOR;
    self.layer.borderWidth = CARD_BORDER_WIDTH;
    
    CGRect centeredFrame = CGRectMake(0, self.frame.size.height/2-PADDING, 
                                      self.frame.size.width, PADDING*2);
    UILabel *deckLabel = [[[UILabel alloc]initWithFrame:centeredFrame]autorelease];
    deckLabel.backgroundColor = [UIColor clearColor];
    deckLabel.textColor = [UIColor whiteColor];
    deckLabel.textAlignment = UITextAlignmentCenter;
    deckLabel.text = @"Discard";
    [self addSubview:deckLabel];
    
  }
  return self;
}


- (void) removeCard {
  [[cards lastObject] removeFromSuperview];
}



- (void) shrinkCard {    
  COSCard *card = [cards lastObject];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(removeCard)];
  CGRect frame = card.frame;
  frame.origin = self.center;
  frame.size = CGSizeMake(0,0);
  card.frame = frame;
  [UIView commitAnimations];
}


- (void) addCard:(COSCard*)card {    
  [cards addObject:card];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(shrinkCard)];
  card.frame = self.frame;
  [UIView commitAnimations];
}


- (void) showDiscardPile {
  CGRect handRegionFrame = CGRectMake(0,
                                      self.frame.origin.y, 
                                      [self superview].frame.size.width, 
                                      CARD_HEIGHT+20);  
  [[discardContainer superview] addSubview:discardContainer];
  [discardContainer release];
  discardContainer = nil;
  discardContainer = [[COSDiscardContainer alloc]initWithFrame:handRegionFrame discardPile:self];
  for (COSCard *card in cards) {
    [discardContainer addCard:card];
  }
  [[self superview] addSubview:discardContainer];
  [discardContainer layoutCards];

}

- (void)clearTouchTime:(NSTimer *)timer {
  [firstTouchTime release];
  firstTouchTime = nil;  
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!firstTouchTime) {
    firstTouchTime = [[NSDate date]retain];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self 
                                   selector:@selector(clearTouchTime:) 
                                   userInfo:nil
                                    repeats:NO];
  } else {
    [self showDiscardPile];
    [firstTouchTime release];
    firstTouchTime = nil;
  }
  
}



@end
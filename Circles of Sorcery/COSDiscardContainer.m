//
//  COSDiscardContainer.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSDiscardContainer.h"
#import "COSDiscardPileView.h"
#import "COSConstants.h"
#import "COSCard.h"

@implementation COSDiscardContainer


- (void) dealloc {
  [discardPile release];
  [hideButton release];
  [super dealloc];
}




- (void) hideDiscardContainer {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
  self.frame = discardPile.frame;
  [UIView commitAnimations];
}


- (void) addHideButton {
  hideButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  hideButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
  [hideButton setTitle:@"Show/Hide" forState:UIControlStateNormal];
  int buttonWidth = 150;
  int buttonHeight = 30;
  hideButton.frame = CGRectMake(self.frame.size.width-buttonWidth-PADDING, 
                                self.frame.size.height-buttonHeight-PADDING, 
                                buttonWidth, buttonHeight);
  [hideButton addTarget:self action:@selector(hideDiscardContainer) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:hideButton];
}


- (id)initWithFrame:(CGRect)frame discardPile:(COSDiscardPileView*)dp {
  self = [super initWithFrame:frame];
  if (self) {
    discardPile = [dp retain];
    [self addHideButton];
  }
  return self;
}


- (void) addCard:(COSCard*)card {  
  [cards addObject:card];
  card.userInteractionEnabled = NO;
}


- (void) layoutCards {
  [super layoutCards];
  [self bringSubviewToFront:hideButton];
}

@end

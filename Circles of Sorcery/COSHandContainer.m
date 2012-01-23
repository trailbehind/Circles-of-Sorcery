//
//  COSHandContainer.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSHandContainer.h"
#import "COSCard.h"
#import "COSConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "COSCardView.h"
#import "COSPlayer.h"

@implementation COSHandContainer
@synthesize cards;


- (void) dealloc {
  [cards release];
  [super dealloc];
  
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      self.layer.borderColor = [[UIColor blueColor]CGColor];
      self.layer.borderWidth = 1;
      self.backgroundColor = [UIColor blackColor];
      self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleWidth;
      self.cards = [NSMutableArray array];
    }
    return self;
}


- (void) layoutCards {
  int offset = 0;
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  for (COSCard *card in self.cards) {
    card.cardView.frame = CGRectMake(offset+PADDING, PADDING, CARD_WIDTH, CARD_HEIGHT );
    offset += card.cardView.frame.size.width+PADDING;
    [self addSubview:card.cardView];
  }
  [UIView commitAnimations];
  self.contentSize = CGSizeMake(offset, self.frame.size.height);
}


- (void) addCard:(COSCard*)card {  
  [cards addObject:card];
}



- (NSArray*) chooseCardsToDicard:(int)numberOfCards {
  NSMutableArray *cardsToDiscard = [NSMutableArray arrayWithObject:[cards lastObject]];
  [cards removeObject:[cards lastObject]];
  //[self layoutCards];
  return cardsToDiscard;
}


- (void) playCard:(COSCard*)card {
  [self.cards removeObject:card];
  [[self superview] addSubview:card.cardView];   
  [card playFromHand];
}


- (void)cardTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event card:(COSCard*)card {
  if (card.player.gold < card.cost) {
    return;
  }
  [card.player gainGold:-card.cost];
  self.scrollEnabled = NO;
  UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:self];
  startPoint = point;
  [self playCard:card];
}


- (void)cardTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event card:(COSCard*)card {
  if (card.player.gold < card.cost) {
    [self layoutCards];
    return;
  }
  self.scrollEnabled = YES;
  if (card.cardView.frame.origin.y 
      >= [card.cardView superview].frame.size.height-CARD_HEIGHT*2-20) {
    int numberOfPositions = (int)self.contentSize.width 
    / ((int)self.frame.size.width+10);
    int position = MIN(numberOfPositions, card.cardView.center.x / self.contentSize.width * numberOfPositions);
    position = MAX(0, position);
    position = MIN([self.cards count], position);
    [self.cards insertObject:card atIndex:position];
  }
  [self layoutCards];
}

/*  // is this if necessary
  if ([[card.cardView superview] isEqual:self]) {
    [[self superview] addSubview:card.cardView]; 
    CGPoint location = [touch locationInView:self]; 
    CGRect newFrame = card.cardView.frame;
    newFrame.origin = location;  
  	card.cardView.frame = newFrame;	    

    [self.cards removeObject:card];
    [self layoutCards];

    if([card.type isEqualToString:@"Effect"]) {
      [card activateForEvent:[[[card.actions objectAtIndex:0]allKeys]objectAtIndex:0]];
      [card.cardView.discardPile addCard:card];
    }
  
  }
} */




@end

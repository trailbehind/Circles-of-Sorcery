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
  return cardsToDiscard;
}


@end

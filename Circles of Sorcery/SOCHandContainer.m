//
//  SOCHandContainer.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SOCHandContainer.h"
#import "SOCCard.h"
#import "SOCConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation SOCHandContainer
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
  for (SOCCard *card in self.cards) {
    card.frame = CGRectMake(offset+PADDING, PADDING, CARD_WIDTH, CARD_HEIGHT );
    offset += card.frame.size.width+PADDING;
    [self addSubview:card];
  }
  [UIView commitAnimations];
  self.contentSize = CGSizeMake(offset, self.frame.size.height);
}


- (void) addCard:(SOCCard*)card {  
  [cards addObject:card];
}

@end

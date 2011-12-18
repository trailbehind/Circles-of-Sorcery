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


- (id)initWithFrame:(CGRect)frame handContainer:(COSHandContainer*)hc {
    self = [super initWithFrame:frame];
    if (self) {
      handContainer = [hc retain];
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
      deckLabel.text = @"Deck";
      [self addSubview:deckLabel];

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
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}



@end

//
//  COSCardView.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSCardView.h"
#import "COSConstants.h"
#import "COSCard.h"
#import "COSDiscardPileView.h"
#import "COSHandContainer.h"
#import "COSDiscardContainer.h"
#import "NSString+multiLineAdjust.h"
#import "COSDeckView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+multiLineAdjust.h"
#import "COSPlayer.h"
#import "COSPlayerArea.h"

@implementation COSCardView
@synthesize handContainer, discardPile, deck, firstTouchTime;

- (void) dealloc {
  [card release];
  
  [handContainer release];
  [discardPile release];
  
  [nameLabel release];
  [costLabel release];
  [artwork release];
  [textLabel release];
  [typeLabel release];
  [rewardLabel release];
  
  [firstTouchTime release];
  
  [super dealloc];
}


// set the backgrounds, colors, and size of the card
- (void) addStyle {
  self.frame = CGRectMake(PADDING, PADDING, CARD_WIDTH, CARD_HEIGHT);
  self.layer.borderColor = CARD_BORDER_COLOR;
  self.layer.borderWidth = CARD_BORDER_WIDTH;
  self.backgroundColor = [UIColor whiteColor];
}


- (UILabel*) addRetainedLabelWithText:(NSString*)text font:(UIFont*)font frame:(CGRect)frame {
  UILabel *label = [[UILabel alloc]initWithFrame:frame];
  label.backgroundColor = [UIColor clearColor];
  label.text = text;
  label.font = font;
  label.adjustsFontSizeToFitWidth = YES;
  [self addSubview:label];
  return label;
}



- (void) highlightForEffect {
  self.layer.borderColor = [[UIColor yellowColor]CGColor];
}


- (void) unhighlight {
  self.layer.borderColor = [[UIColor redColor]CGColor];
}



- (id)initWithCard:(COSCard*)c {
  self = [super init];
  if (self) {
    
    card = [c retain];
    [self addStyle];
        
    // name label at top of card
    int costLabelWidth = 15;
    CGRect nameLabelFrame = CGRectMake(PADDING, 
                                       PADDING, 
                                       self.frame.size.width-PADDING*2.5-costLabelWidth, 
                                       17);
    nameLabel = [self addRetainedLabelWithText:card.name
                                          font:TITLE_FONT
                                         frame:nameLabelFrame];

    CGRect costLabelFrame = CGRectMake(self.frame.size.width-PADDING-costLabelWidth, 
                                       PADDING, 
                                       costLabelWidth, 
                                       17);
    // cost label at top of card
    UIImageView *gold = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gold.png"]]autorelease];
    CGRect goldFrame = costLabelFrame;
    goldFrame.origin.x -=6;
    goldFrame.origin.y -=3;
    goldFrame.size.width = 22;
    goldFrame.size.height = 22;
    gold.frame = goldFrame;
    [self addSubview:gold];
    costLabel = [self addRetainedLabelWithText:[NSString stringWithFormat:@"%d", card.cost]
                                          font:TITLE_FONT
                                         frame:costLabelFrame];
        
    // art image just under the name
    CGRect artworkFrame = CGRectMake(PADDING, 
                                     PADDING*3, 
                                     self.frame.size.width-PADDING*2, 
                                     PADDING*6.5);
    artwork = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    artwork.backgroundColor = [UIColor blackColor];
    artwork.frame = artworkFrame;
    artwork.layer.cornerRadius = 5;
    artwork.layer.borderWidth = 1;
    [self addSubview:artwork];
    
    // card text under the image
    int offset = artwork.frame.size.height+artwork.frame.origin.y+PADDING;
    int textLabelHeight = self.frame.size.height - offset - PADDING*4;
    CGRect textLabelFrame = CGRectMake(PADDING, 
                                       offset, 
                                       self.frame.size.width-PADDING*2, 
                                       textLabelHeight);
    float fontSize = [[card displayText] fontSizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] 
                                          constrainedToSize:textLabelFrame.size];
    textLabel = [self addRetainedLabelWithText:[card displayText]
                                          font:[UIFont fontWithName:@"Helvetica" size:fontSize]
                                         frame:textLabelFrame];
    textLabel.numberOfLines = 0;
    
    CGRect typeLabelFrame = CGRectMake(PADDING, 
                                       self.frame.size.height - PADDING*3, 
                                       self.frame.size.width-PADDING*3-costLabelWidth, 
                                       PADDING*2);
    typeLabel = [self addRetainedLabelWithText:card.subtype
                                          font:TITLE_FONT
                                         frame:typeLabelFrame];

    CGRect rewardLabelFrame = CGRectMake(self.frame.size.width-PADDING-costLabelWidth-8, 
                                        self.frame.size.height - PADDING*3, 
                                        costLabelWidth, 
                                        PADDING*2);
    rewardLabel = [self addRetainedLabelWithText:[NSString stringWithFormat:@"%d", card.reward]
                                          font:TITLE_FONT
                                         frame:rewardLabelFrame];
    rewardLabel.textAlignment = UITextAlignmentRight;
    UIImageView *star = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star.png"]]autorelease];
    CGRect starFrame = rewardLabelFrame;
    starFrame.origin.x -=5;
    starFrame.origin.y -=6;
    starFrame.size.width = 32;
    starFrame.size.height = 32;
    star.frame = starFrame;
    [self addSubview:star];
    [self addSubview:rewardLabel];
    
  }
  return self;
}


- (void)clearTouchTime:(NSTimer *)timer {
  [firstTouchTime release];
  firstTouchTime = nil;  
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if ([handContainer.cards containsObject:card]) {
    [handContainer cardTouchesBegan:touches withEvent:event card:card];
    return;
  }
  
  if ([discardPile.cards containsObject:card]) {
    [discardPile.discardContainer cardTouchesBegan:touches withEvent:event card:card];
    return;
  }

  
  if ([card.player.cardsInPlay containsObject:card]) {
    if (!firstTouchTime) { // first tap
      self.firstTouchTime = [NSDate date];
      [NSTimer scheduledTimerWithTimeInterval:1
                                       target:self 
                                     selector:@selector(clearTouchTime:) 
                                     userInfo:nil
                                      repeats:NO];
    } else {  // double tap
      [firstTouchTime release];
      firstTouchTime = nil; 
      [card activateIfActivatable];
    }
  }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if ([discardPile.cards containsObject:card]
      || [deck.cards containsObject:card]) {
    if (firstTouchTime) {
      [firstTouchTime release];
      firstTouchTime = nil;
      //if ([discardPile.cards containsObject:card]) {
      //  [discardPile.cards removeObject:card];
      //  [discardPile.discardContainer.cards removeObject:card];
      //  [handContainer addCard:card];
      //  [handContainer layoutCards];
      //}
  
      if ([deck.cards containsObject:card]) {
        [deck.cards removeObject:card];
        [deck.discardContainer.cards removeObject:card];
        [handContainer addCard:card];
        [handContainer layoutCards];
      }
      
      
    }
    return;
  }
  
  [handContainer cardTouchesEnded:touches withEvent:event card:card];  
  
  if (CGRectIntersectsRect(self.frame, discardPile.frame)) {
    [discardPile addCard:card];
    [card.player.playerArea removeCard:card];

  }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];   
  CGPoint location = [touch locationInView:self.superview]; 
  
  self.center = location;
}


@end

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

@implementation COSCardView
@synthesize handContainer, discardPile, deck;

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
    typeLabel = [self addRetainedLabelWithText:card.type
                                          font:TITLE_FONT
                                         frame:typeLabelFrame];

    CGRect rewardLabelFrame = CGRectMake(self.frame.size.width-PADDING-costLabelWidth, 
                                        self.frame.size.height - PADDING*3, 
                                        costLabelWidth, 
                                        PADDING*2);
    rewardLabel = [self addRetainedLabelWithText:[NSString stringWithFormat:@"%d", card.reward]
                                          font:TITLE_FONT
                                         frame:rewardLabelFrame];
    rewardLabel.textAlignment = UITextAlignmentRight;
    [self addSubview:rewardLabel];
    
  }
  return self;
}


- (void)clearTouchTime:(NSTimer *)timer {
  [firstTouchTime release];
  firstTouchTime = nil;  
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if (![handContainer.cards containsObject:self]) {
    if (!firstTouchTime) {
      NSLog(@"First touch");
      firstTouchTime = [[NSDate date]retain];
      [NSTimer scheduledTimerWithTimeInterval:1
                                       target:self 
                                     selector:@selector(clearTouchTime:) 
                                     userInfo:nil
                                      repeats:NO];
    } else {
      NSLog(@"Second touch");
      if ([discardPile.cards containsObject:self]) {
        return;
      }
      [firstTouchTime release];
      firstTouchTime = nil;
      [UIView beginAnimations:nil context:nil];
      [UIView setAnimationDuration:0.25];
      if (CGAffineTransformEqualToTransform(self.transform,CGAffineTransformIdentity)) {
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
        self.transform = transform;
      } else {
        self.transform = CGAffineTransformIdentity;
      }
      [UIView commitAnimations];
    }
    
  }
  
  handContainer.scrollEnabled = NO;
  UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:self];
  startPoint = point;
  if ([[self superview] isEqual:handContainer]) {
    [[[self superview]superview]addSubview:self]; 
    
    CGPoint location = [touch locationInView:self.superview]; 
    CGRect newFrame = self.frame;
    newFrame.origin = location;  
  	self.frame = newFrame;	
    
  }
  [handContainer.cards removeObject:self];
  [handContainer layoutCards];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if ([discardPile.cards containsObject:self]
      || [deck.cards containsObject:self]) {
    if (firstTouchTime) {
      [firstTouchTime release];
      firstTouchTime = nil;
      if ([discardPile.cards containsObject:self]) {
        [discardPile.cards removeObject:self];
        [discardPile.discardContainer.cards removeObject:self];
        [handContainer addCard:self];
        [handContainer layoutCards];
        NSLog(@"discard pile cards are %d", [discardPile.cards count]);
        NSLog(@"discard pile container cards are %d", [discardPile.discardContainer.cards count]);
      }
      NSLog(@"The discardContainer is %@", deck.discardContainer);
      NSLog(@"The handcontainer is %@", handContainer  );
      NSLog(@"I am %@", self);
      if ([deck.cards containsObject:self]) {
        [deck.cards removeObject:self];
        [deck.discardContainer.cards removeObject:self];
        [handContainer addCard:self];
        [handContainer layoutCards];
      }
      
      
    }
    return;
  }
  
  handContainer.scrollEnabled = YES;
  if (self.frame.origin.y >= [self superview].frame.size.height-CARD_HEIGHT-20-CARD_HEIGHT) {
    int numberOfPositions = (int)handContainer.contentSize.width 
    / ((int)self.frame.size.width+10);
    int position = MIN(numberOfPositions, self.center.x / handContainer.contentSize.width * numberOfPositions);
    position = MAX(0, position);
    [handContainer.cards insertObject:self atIndex:position];
  }
  [handContainer layoutCards];
  
  if (CGRectIntersectsRect(self.frame, discardPile.frame)) {
    [discardPile addCard:self];
  }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];   
  CGPoint location = [touch locationInView:self.superview]; 
  
  self.center = location;
}


@end

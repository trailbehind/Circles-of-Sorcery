//
//  COSCard.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSCard.h"
#import "COSConstants.h"
#import "COSDiscardPileView.h"
#import "COSHandContainer.h"
#import "COSDiscardContainer.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+multiLineAdjust.h"

@implementation COSCard
@synthesize handContainer, discardPile;




- (void) dealloc {
  [handContainer release];
  [discardPile release];

  [nameLabel release];
  [costLabel release];
  [artwork release];
  [textLabel release];
  [keywordsLabel release];
  [typeLabel release];
  [powerLabel release];
  [super dealloc];
}


- (void) incrementLife {
  lifeValue = MIN(maxLife, lifeValue+1);
  costLabel.text = [NSString stringWithFormat:@"%d", lifeValue];
}


- (void) decrementLife {
  lifeValue--;
  costLabel.text = [NSString stringWithFormat:@"%d", lifeValue];
  if (lifeValue == 0) {
    [discardPile addCard:self];
  }
}


- (id)initWithCardInfo:(NSDictionary*)cardInfo {
    self = [super init];
    if (self) {
      
      self.frame = CGRectMake(PADDING, PADDING, CARD_WIDTH, CARD_HEIGHT);
      self.layer.borderColor = CARD_BORDER_COLOR;
      self.layer.borderWidth = CARD_BORDER_WIDTH;
      self.backgroundColor = [UIColor whiteColor];
      
      int costLabelWidth = 15;
      CGRect nameLabelFrame = CGRectMake(PADDING, 
                                         PADDING, 
                                         self.frame.size.width-PADDING*2.5-costLabelWidth, 
                                         17);
      nameLabel = [[UILabel alloc]initWithFrame:nameLabelFrame];
      nameLabel.backgroundColor = [UIColor clearColor];
      nameLabel.text = [cardInfo objectForKey:@"name"];
      nameLabel.font = TITLE_FONT;
      nameLabel.adjustsFontSizeToFitWidth = YES;
      [self addSubview:nameLabel];

      CGRect costLabelFrame = CGRectMake(self.frame.size.width-PADDING-costLabelWidth, 
                                         PADDING, 
                                         costLabelWidth, 
                                         17);
      costLabel = [[UILabel alloc]initWithFrame:costLabelFrame];
      costLabel.font = TITLE_FONT;
      costLabel.backgroundColor = [UIColor clearColor];
      costLabel.textAlignment = UITextAlignmentRight;
      costLabel.text = [cardInfo objectForKey:@"cost"];
      [self addSubview:costLabel];
      lifeValue = [[cardInfo objectForKey:@"cost"]intValue];
      maxLife = [[cardInfo objectForKey:@"cost"]intValue];
      
      int artworkWidth = self.frame.size.width-PADDING*2;
      if ([[cardInfo objectForKey:@"type"] isEqualToString:@"Beast"]) {
        artworkWidth -=40;
        int buttonSize = 30;
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        plusButton.frame = CGRectMake(self.frame.size.width - buttonSize-PADDING, 
                                      costLabelFrame.size.height+costLabelFrame.origin.y+PADDING/2, 
                                      buttonSize, buttonSize);
        [plusButton addTarget:self 
                       action:@selector(incrementLife) 
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];

        UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [minusButton setTitle:@"-" forState:UIControlStateNormal];
        minusButton.frame = CGRectMake(self.frame.size.width - buttonSize-PADDING, 
                                      costLabelFrame.size.height+costLabelFrame.origin.y+PADDING+buttonSize, 
                                      buttonSize, buttonSize);
        [minusButton addTarget:self 
                       action:@selector(decrementLife) 
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:minusButton];

      }
      CGRect artworkFrame = CGRectMake(PADDING, 
                                         PADDING*3, 
                                         artworkWidth, 
                                         PADDING*6.5);
      artwork = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
      artwork.backgroundColor = [UIColor blackColor];
      artwork.frame = artworkFrame;
      artwork.layer.cornerRadius = 5;
      artwork.layer.borderWidth = 1;
      [self addSubview:artwork];

      int offset = artwork.frame.size.height+artwork.frame.origin.y+PADDING;
      int textLabelHeight = self.frame.size.height - offset - PADDING*4;
      
      CGRect keywordsLabelFrame = CGRectMake(PADDING, 
                                         offset, 
                                         self.frame.size.width-PADDING*2, 
                                         PADDING*2);
      keywordsLabel = [[UILabel alloc]initWithFrame:keywordsLabelFrame];
      keywordsLabel.backgroundColor = [UIColor clearColor];
      keywordsLabel.textAlignment = UITextAlignmentRight;
      keywordsLabel.text = [cardInfo objectForKey:@"keywords"];
      [self addSubview:keywordsLabel];
      
      if ([cardInfo objectForKey:@"keywords"]) {
        offset += PADDING*3;
        textLabelHeight -= PADDING*3;
      }
      CGRect textLabelFrame = CGRectMake(PADDING, 
                                         offset, 
                                         self.frame.size.width-PADDING*2, 
                                         textLabelHeight);
      textLabel = [[UILabel alloc]initWithFrame:textLabelFrame];
      textLabel.text = [cardInfo objectForKey:@"text"];
      
      CGFloat fontSize = [textLabel.text fontSizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:textLabel.frame.size];
      textLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
      textLabel.backgroundColor = [UIColor clearColor];
      textLabel.numberOfLines = 0;
      [self addSubview:textLabel];
      
      CGRect typeLabelFrame = CGRectMake(PADDING, 
                                         self.frame.size.height - PADDING*3, 
                                         self.frame.size.width-PADDING*3-costLabelWidth, 
                                         PADDING*2);
      typeLabel = [[UILabel alloc]initWithFrame:typeLabelFrame];
      typeLabel.adjustsFontSizeToFitWidth = YES;
      typeLabel.backgroundColor = [UIColor clearColor];
      typeLabel.adjustsFontSizeToFitWidth = YES;
      typeLabel.text = [NSString stringWithFormat:@"%@ - %@", 
                         [cardInfo objectForKey:@"class"],
                        [cardInfo objectForKey:@"type"]];
      
      if (![[cardInfo objectForKey:@"beast_type"]isEqualToString:@"none"]) {
        typeLabel.text = [NSString stringWithFormat:@"%@, %@", 
                          typeLabel.text,
                          [cardInfo objectForKey:@"beast_type"]];
      }
      
      [self addSubview:typeLabel];

      CGRect powerLabelFrame = CGRectMake(self.frame.size.width-PADDING-costLabelWidth, 
                                         self.frame.size.height - PADDING*3, 
                                         costLabelWidth, 
                                         PADDING*2);
      powerLabel = [[UILabel alloc]initWithFrame:powerLabelFrame];
      powerLabel.backgroundColor = [UIColor clearColor];
      powerLabel.textAlignment = UITextAlignmentRight;
      powerLabel.text = [cardInfo objectForKey:@"power"];
      [self addSubview:powerLabel];

      //self.exclusiveTouch = YES;
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
  
  if ([discardPile.cards containsObject:self]) {
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

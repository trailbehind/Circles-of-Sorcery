//
//  PlusMinusCounter.m
//  Circles of Sorcery
//
//  Created by EFB on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSPlusMinusCounter.h"
#import "COSConstants.h"

@implementation COSPlusMinusCounter
@synthesize counterValue;

- (void) dealloc {
  [titleLabel release];
  [counterLabel release];
  [super dealloc];
}


- (void) setCounterLabelFrame {
  CGSize maximumLabelSize = CGSizeMake(200,17);
  CGSize expectedLabelSize = [counterLabel.text sizeWithFont:counterLabel.font 
                                         constrainedToSize:maximumLabelSize 
                                             lineBreakMode:counterLabel.lineBreakMode];
  counterLabel.frame = CGRectMake(self.frame.size.width/2-expectedLabelSize.width/2, 
                                  titleLabel.frame.origin.y + titleLabel.frame.size.height, 
                                  expectedLabelSize.width, 
                                  expectedLabelSize.height);
}

- (void) incrementCounter {
  counterValue++;
  counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
  [self setCounterLabelFrame];
}

- (void) decrementCounter {
  counterValue--;
  counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
  [self setCounterLabelFrame];
}


- (void) addButtonsAndLabels:(NSString*)title icon:(NSString*)icon showPlus:(BOOL)showPlus showMinus:(BOOL)showMinus{
  int buttonSize = 60;
  
  UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [minusButton setTitle:@"-" forState:UIControlStateNormal];
  minusButton.frame = CGRectMake(0, 0, buttonSize, buttonSize);
  [minusButton addTarget:self 
                  action:@selector(decrementCounter) 
        forControlEvents:UIControlEventTouchUpInside];
  if (showMinus) {
    [self addSubview:minusButton];
  }
  titleLabel = [[UILabel alloc]init];
  titleLabel.backgroundColor = [UIColor clearColor];
  titleLabel.text = title;
  titleLabel.textAlignment = UITextAlignmentCenter;
  
    titleLabel.frame = CGRectMake(0, 
                                0, 
                                self.frame.size.width, 
                                20);    
  [self addSubview:titleLabel];
  
  
  
  counterLabel = [[UILabel alloc]init];
  counterLabel.textAlignment = UITextAlignmentCenter;
  counterLabel.backgroundColor = [UIColor clearColor];
  counterLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
  counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
  [self addSubview:counterLabel];
  
  
  UIImageView *star = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:icon]]autorelease];
  CGRect starFrame;
  starFrame.origin.x =self.frame.size.width/2-16;
  starFrame.origin.y =40;
  starFrame.size.width = 32;
  starFrame.size.height = 32;
  star.frame = starFrame;
  [self addSubview:star];

  
  
  UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [plusButton setTitle:@"+" forState:UIControlStateNormal];
  plusButton.frame = CGRectMake(titleLabel.frame.size.width/2-titleLabel.frame.origin.x/2-buttonSize/2, 
                                titleLabel.frame.size.height+2, 
                                buttonSize, buttonSize);
  [plusButton addTarget:self 
                  action:@selector(incrementCounter) 
        forControlEvents:UIControlEventTouchUpInside];
  if (showPlus) {
    [self addSubview:plusButton];
    [counterLabel removeFromSuperview];
  } 
  [self setCounterLabelFrame];
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title icon:(NSString*)icon startCount:(int)startCount  showPlus:(BOOL)showPlus showMinus:(BOOL)showMinus {
  self = [super initWithFrame:frame];
  if (self) {
    counterValue = startCount;
    [self addButtonsAndLabels:title icon:icon showPlus:showPlus showMinus:showMinus];
  }
  return self;
}


@end

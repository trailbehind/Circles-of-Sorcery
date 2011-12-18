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
                                  titleLabel.frame.origin.y + titleLabel.frame.size.height - 4, 
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


- (void) addButtonsAndLabels:(NSString*)title {
  int buttonSize = 30;
  
  UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [minusButton setTitle:@"-" forState:UIControlStateNormal];
  minusButton.frame = CGRectMake(0, 0, buttonSize, buttonSize);
  [minusButton addTarget:self 
                  action:@selector(decrementCounter) 
        forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:minusButton];
  
  titleLabel = [[UILabel alloc]init];
  titleLabel.backgroundColor = [UIColor clearColor];
  titleLabel.text = title;
  
  CGSize maximumLabelSize = CGSizeMake(200,17);
  CGSize expectedLabelSize = [titleLabel.text sizeWithFont:titleLabel.font 
                                         constrainedToSize:maximumLabelSize 
                                             lineBreakMode:titleLabel.lineBreakMode];
  titleLabel.frame = CGRectMake(minusButton.frame.size.width+PADDING/2, 
                                -5, 
                                expectedLabelSize.width, 
                                expectedLabelSize.height);    
  [self addSubview:titleLabel];
  
  counterLabel = [[UILabel alloc]init];
  counterLabel.backgroundColor = [UIColor clearColor];
  counterLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
  counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
  [self addSubview:counterLabel];
  
  UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [plusButton setTitle:@"+" forState:UIControlStateNormal];
  plusButton.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+PADDING/2, 
                                0, 
                                buttonSize, buttonSize);
  [plusButton addTarget:self 
                  action:@selector(incrementCounter) 
        forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:plusButton];
  
  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, buttonSize*2+PADDING+titleLabel.frame.size.width, 40);
  [self setCounterLabelFrame];
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title startCount:(int)startCount {
  self = [super initWithFrame:frame];
  if (self) {
    counterValue = startCount;
    [self addButtonsAndLabels:title];
  }
  return self;
}


@end

//
//  PlusMinusCounter.m
//  Circles of Sorcery
//
//  Created by EFB on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSPlusMinusCounter.h"
#import "COSConstants.h"

@implementation PlusMinusCounter


- (void) incrementCounter {
  
}

- (void) decrementCounter {
  
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
  
  UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
  titleLabel.backgroundColor = [UIColor clearColor];
  titleLabel.text = title;
  
  CGSize maximumLabelSize = CGSizeMake(200,20);
  CGSize expectedLabelSize = [titleLabel.text sizeWithFont:titleLabel.font 
                                         constrainedToSize:maximumLabelSize 
                                             lineBreakMode:titleLabel.lineBreakMode];
  titleLabel.frame = CGRectMake(minusButton.frame.size.width+PADDING/2, 
                                minusButton.frame.size.height+PADDING/2, 
                                expectedLabelSize.width, 
                                expectedLabelSize.height);    
  [self addSubview:titleLabel];
  
  UILabel *counterLabel = [[[UILabel alloc]init]autorelease];
  counterLabel.backgroundColor = [UIColor clearColor];
  counterLabel.text = [NSString stringWithFormat:@"%d", counterValue];
  int counterLabelWidth = 30;
  counterLabel.frame = CGRectMake(titleLabel.frame.origin.x/2+titleLabel.frame.size.width/2-counterLabelWidth/2, 
                                  titleLabel.frame.size.height+3, 
                                  counterLabelWidth, 
                                  20);
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
  
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title {
  self = [super initWithFrame:frame];
  if (self) {
    counterValue = 0;
    [self addButtonsAndLabels:title];
  }
  return self;
}


@end

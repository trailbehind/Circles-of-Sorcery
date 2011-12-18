//
//  COSOpponentTray.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSOpponentTray.h"
#import "COSConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation COSOpponentTray


- (void) toggleHidden {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];

  CGRect fr = self.frame;
  if (self.frame.origin.y == -668) {
    fr.origin.y = -200;    
  } else {
    fr.origin.y = -668;
  }
  self.frame = fr;
  [UIView commitAnimations];

  
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.backgroundColor = [UIColor yellowColor];
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.layer.borderColor = [[UIColor blueColor]CGColor];
      self.layer.borderWidth = 1;
      
      UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      showButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;;
      [showButton setTitle:@"Show/Hide" forState:UIControlStateNormal];
      int buttonWidth = 150;
      int buttonHeight = 30;
      showButton.frame = CGRectMake(self.frame.size.width-buttonWidth-PADDING, self.frame.size.height-buttonHeight-PADDING, buttonWidth, buttonHeight);
      [showButton addTarget:self action:@selector(toggleHidden) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:showButton];
      
  }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  PlusMinusCounter.h
//  Circles of Sorcery
//
//  Created by EFB on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COSPlusMinusCounter : UIView {

  int counterValue;
  UILabel *counterLabel, *titleLabel;
  
}


- (id)initWithFrame:(CGRect)frame title:(NSString*)title startCount:(int)startCount;
- (void) incrementCounter;
- (void) decrementCounter;


@end

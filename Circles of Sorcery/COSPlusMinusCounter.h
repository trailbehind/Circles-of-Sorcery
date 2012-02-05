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

@property(nonatomic,assign) int counterValue;


- (id)initWithFrame:(CGRect)frame title:(NSString*)title icon:(NSString*)icon startCount:(int)startCount  showPlus:(BOOL)showPlus showMinus:(BOOL)showMinus;
- (void) incrementCounter;
- (void) decrementCounter;


@end

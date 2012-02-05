//
//  COSTurnCounter.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSPlayer;

@interface COSTurnCounter : UIView {
  
  UILabel *counterLabel;
  int turnCount;
  COSPlayer *player;
  
}

- (id)initWithFrame:(CGRect)frame player:(COSPlayer*)p;
- (int) turnCount;


@end

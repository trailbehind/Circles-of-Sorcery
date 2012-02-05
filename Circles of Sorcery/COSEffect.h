//
//  COSEffect.h
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class  COSPlayer;


@interface COSEffect : NSObject {  
  NSString *resourceToGive, *resourceToGet;
  int giveAmount, getAmount;
}



- (void) activate:(COSPlayer*)player;
- (void) activateTradeEffect:(COSPlayer*)player;

- (id) initForResourcesToGive:(NSString*)s
                    payAmount:(int)ra
                resourceToGet:(NSString*)gr 
            forResourceAmount:(int)ga;

@end

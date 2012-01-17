//
//  COSConvertWidget.h
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSPlusMinusCounter.h"

@class COSEffect, COSPlayer;

@interface COSConvertWidget : COSPlusMinusCounter {
  
  COSEffect *effect;
  COSPlayer *player;
  
}

- (id) initForResourcesToGive:(NSString*)resourceToGive
                resourceToGet:(NSString*)resourceToGet
                    payAmount:(int)payAmount
            forResourceAmount:(int)getAmount 
                       player:(COSPlayer*)p;

@end

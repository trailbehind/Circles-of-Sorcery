//
//  ChangeGoldModalView.h
//  Circles of Sorcery
//
//  Created by EFB on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSConvertWidget, COSPlayer;


@interface ChangeGoldModalView : UIViewController {
  
  COSConvertWidget *widget;
  
}


- (id)  initWithAmount:(int)amount
     forResourcesNamed:(NSString*)resourcesToGain
       resourcesToGain:(int)resourcesToGainQuantity 
                player:(COSPlayer*)player;

@end

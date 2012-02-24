//
//  ChangeGoldModalView.m
//  Circles of Sorcery
//
//  Created by EFB on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChangeGoldModalView.h"
#import "COSConvertWidget.h"
#import "COSPlayer.h"

@implementation ChangeGoldModalView 

- (id) initWithAmount:(int)amount
    forResourcesNamed:(NSString*)resourcesToGain
      resourcesToGain:(int)resourcesToGainQuantity 
               player:(COSPlayer*)player {
  self = [super init];
  widget = [[COSConvertWidget alloc] initForResourcesToGive:@"GET_GOLD"
                                               resourceToGet:resourcesToGain 
                                                   payAmount:amount
                                           forResourceAmount:resourcesToGainQuantity
                                                      player:player];
  return self;
  
}

- (void) loadView {
  [super loadView];
  [self.view addSubview:widget];
}

@end

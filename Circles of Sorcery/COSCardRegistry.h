//
//  COSCardRegistry.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface COSCardRegistry : NSObject {
  
  NSMutableArray *cardList;
  NSMutableDictionary *cardIndex;
  NSDictionary *actionTranslations;
  
}

@property(nonatomic, retain) NSMutableArray *cardList;
@property(nonatomic, retain) NSMutableDictionary *cardIndex;
@property(nonatomic, retain) NSDictionary *actionTranslations;

- (id) initWithFilename:(NSString*)filename;


@end

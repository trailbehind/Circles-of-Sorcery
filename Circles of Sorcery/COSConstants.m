//
//  COSConstants.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSConstants.h"

@implementation COSConstants

NSString* documentsDirectory() {
  static NSString* dir = nil;
  if (!dir) {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    dir = [[paths objectAtIndex:0] retain];	
    
  }
  return dir;
}


@end

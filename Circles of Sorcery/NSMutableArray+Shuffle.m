//
//  NSMutableArray+Shuffle.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
  
  static BOOL seeded = NO;
  if(!seeded)
  {
    seeded = YES;
    srandom(time(NULL));
  }
  
  NSUInteger count = [self count];
  for (NSUInteger i = 0; i < count; ++i) {
    // Select a random element between i and end of array to swap with.
    int nElements = count - i;
    int n = (random() % nElements) + i;
    [self exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
}
@end

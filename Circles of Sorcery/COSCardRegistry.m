//
//  COSCardRegistry.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSCardRegistry.h"
#import "CJSONDeserializer.h"

@implementation COSCardRegistry
@synthesize cardIndex, cardList, actionTranslations;


- (void) dealloc {
  [cardList release];
  [cardIndex release];
  [actionTranslations release];
  [super dealloc];
}

- (id) initWithFilename:(NSString*)filename {
  self = [super init];
  
  NSString* filePath = [[NSBundle mainBundle] pathForResource:@"card_data.json" ofType:nil];
  NSData *fileData = [NSData dataWithContentsOfFile:filePath];                       
  cardList = [[[CJSONDeserializer deserializer] deserialize:fileData error:nil]retain];
  //NSLog(@"The list is %@ with count %d", cardList, [cardList count]);
  cardIndex = [[NSMutableDictionary dictionaryWithCapacity:[cardList count]]retain];
  for (NSDictionary *cardDict in cardList) {
    [cardIndex setObject:cardDict forKey:[cardDict objectForKey:@"name"]];
  }
  //NSLog(@"The card index is %@", cardIndex);
  
  NSString *translationFilePath = [[NSBundle mainBundle] pathForResource:@"ability_translation.json" ofType:nil];
  NSData *translationFileData = [NSData dataWithContentsOfFile:translationFilePath];                       
  actionTranslations = [[[CJSONDeserializer deserializer] deserialize:translationFileData error:nil]retain];

  return self;
  
}

@end

//
//  COSPlayerArea.m
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>
#import "COSPlayerArea.h"
#import "COSDeckView.h"
#import "COSCard.h"
#import "COSConstants.h"
#import "COSDiscardPileView.h"
#import "COSHandContainer.h"
#import "COSPlusMinusCounter.h"
#import "NSMutableArray+Shuffle.h"


@implementation COSPlayerArea


- (void) dealloc {
  [lifeCounter release];
  [manaCounter release];
  [deck release];
  [super dealloc];
}


- (void) endTurn {
  // [manaCounter incrementCounter];
  [deck drawCard];
}


NSString *readLineAsNSString(FILE *file) {
  char buffer[4096];
  
  // tune this capacity to your liking -- larger buffer sizes will be faster, but
  // use more memory
  NSMutableString *result = [NSMutableString stringWithCapacity:256];
  
  // Read up to 4095 non-newline characters, then read and discard the newline
  int charsRead;
  do
  {
    if(fscanf(file, "%4095[^\n]%n%*c", buffer, &charsRead) == 1)
      [result appendFormat:@"%s", buffer];
    else
      break;
  } while(charsRead == 4095);
  
  return result;
}


+ (NSMutableArray*)readLine:(NSString*)fileLine {
  NSMutableArray* partsData = [[NSMutableArray alloc] init];
  NSMutableArray* phrase = [[NSMutableArray alloc] init];
  
  NSArray* tempPartsData = [fileLine componentsSeparatedByString:@","];
  for (NSString* origPart in tempPartsData) {
    
    NSString* part = [[NSString alloc] initWithString:[origPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    if ([part length] == 0) {
      [part release];
      continue;
    }
    
    if ([part characterAtIndex:0] == '"' && [part characterAtIndex:[part length]-1] != '"') {
      // Starting phrase
      [phrase addObject:[part substringFromIndex:1]];
    } else if ([part characterAtIndex:0] == '"' && [part length] == 1) {
      // Just a lonely quotation mark--a phrase started or ended with a comma
      [phrase addObject:@""];
      if ([phrase count] == 0) {
        // phrase begins with a comma
      } else {
        // phrase ends with a comma
        [partsData addObject:[phrase componentsJoinedByString:@","]];
        [phrase removeAllObjects];
      }
    } else if ([part characterAtIndex:0] == '"' && [part characterAtIndex:[part length]-1] == '"') {
      // Complete quoted phrase
      NSRange inner;
      inner.location = 1;
      inner.length = [part length] - 2;
      [partsData addObject:[part substringWithRange:inner]];
    } else if ([part characterAtIndex:[part length]-1] == '"') {
      // Ending phrase
      [phrase addObject:[part substringToIndex:[part length]-1]];
      [partsData addObject:[phrase componentsJoinedByString:@","]];
      [phrase removeAllObjects];
    } else if ([phrase count] > 0) {
      // Continuing phrase
      [phrase addObject:part];
    } else {
      // Complete phrase
      [partsData addObject:part];
    }
    
    [part release];
  }
  
  [phrase removeAllObjects];
  [phrase release];
  
  return [partsData autorelease];
}


- (void) addDeck:(COSHandContainer*)handContainer deckName:(NSString*)deckName {
  int deckHeight = CARD_HEIGHT * .75;
  int deckWidth = CARD_WIDTH * .75;
  CGRect discardFrame = CGRectMake(self.frame.size.width- deckWidth - PADDING, 
                                   self.frame.size.height- deckHeight - CARD_HEIGHT*2 + 10, 
                                   deckWidth, deckHeight);
  
  COSDiscardPileView *discard = [[[COSDiscardPileView alloc]initWithFrame:discardFrame]autorelease];
  discard.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:discard];
  
  
  
  CGRect deckFrame = CGRectMake(self.frame.size.width-deckWidth - PADDING, 
                                self.frame.size.height-CARD_HEIGHT-20 - deckHeight - PADDING, 
                                deckWidth, deckHeight);
  deck = [[COSDeckView alloc]initWithFrame:deckFrame 
                                           handContainer:handContainer];
  deck.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
  [self addSubview:deck];
  
  
  NSString* fullPath = [[NSBundle mainBundle] pathForResource:deckName ofType:nil];
  FILE *file = fopen([fullPath UTF8String], "r");
  
  NSMutableArray *cards = [NSMutableArray array];  
  while(!feof(file)) {
    NSString *line = readLineAsNSString(file);
    NSArray *parts = [COSPlayerArea readLine:line];
    NSMutableDictionary *cardDict = [NSMutableDictionary dictionary];
    [cardDict setValue:[parts objectAtIndex:0] forKey:@"name"];
    [cardDict setValue:[parts objectAtIndex:1] forKey:@"class"];
    [cardDict setValue:[parts objectAtIndex:2] forKey:@"type"];
    [cardDict setValue:[parts objectAtIndex:3] forKey:@"cost"];
    [cardDict setValue:[parts objectAtIndex:4] forKey:@"power"];
    [cardDict setValue:[parts objectAtIndex:5] forKey:@"beast_type"];
    [cardDict setValue:[parts objectAtIndex:6] forKey:@"text"];
    [cardDict setValue:[parts objectAtIndex:7] forKey:@"abilities"];
    [cards addObject:cardDict];
    NSLog(@"The line parts are %@", parts);
  }
  fclose(file);
 
  [cards shuffle];
  
  for (NSDictionary *cardDict in cards) {
    COSCard *card = [[[COSCard alloc]initWithCardInfo:cardDict]autorelease];
    card.discardPile = discard;
    card.deck = deck;
    card.handContainer = handContainer;
    [deck addCard:card];
  }
  
  [deck drawHand];
}


- (void) setupPlayArea:(NSString*)deckName {
  
  
  CGRect lifeCounterFrame = CGRectMake(PADDING, 90, 0, 0);
  lifeCounter = [[COSPlusMinusCounter alloc]initWithFrame:lifeCounterFrame title:@"Gold" startCount:0];
  [self addSubview:lifeCounter];

  CGRect manaCounterFrame = CGRectMake(PADDING, 
                                       lifeCounterFrame.origin.y+lifeCounterFrame.size.height+PADDING*6, 
                                       0, 0);
  manaCounter = [[COSPlusMinusCounter alloc]initWithFrame:manaCounterFrame title:@"Animals" startCount:0];
  [self addSubview:manaCounter];

  CGRect handRegionFrame = CGRectMake(0,
                                      self.frame.size.height-CARD_HEIGHT-20, 
                                      self.frame.size.width, 
                                      CARD_HEIGHT+20);  
  COSHandContainer *handContainer = [[[COSHandContainer alloc]initWithFrame:handRegionFrame]autorelease];
  [self addSubview:handContainer];
  
  [self addDeck:handContainer deckName:deckName];

  
  
}

- (id)initWithFrame:(CGRect)frame deckName:(NSString*)deckName {
    self = [super initWithFrame:frame];
    if (self) {
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
      self.backgroundColor = [UIColor colorWithRed:.3 green:.5 blue:.7 alpha:.5];
      [self setupPlayArea:deckName];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

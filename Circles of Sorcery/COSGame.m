//
//  COSGame.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSGame.h"
#import "COSGameLayout.h"
#import "COSCardRegistry.h"
#import "COSPlayer.h"
#import "COSDeckBuilderTableView.h"

@implementation COSGame 
@synthesize cardRegistry, players;

- (void) dealloc {
  [cardRegistry release];
  [gameLayout release];
  [players release];
  [deckBuilder release];
  [super dealloc];
}


- (void) loadView {
  [super loadView];
}


- (id) initWithCardRegistryFile:(NSString*)filename {
  self = [super init];
  cardRegistry = [[COSCardRegistry alloc]initWithFilename:filename];
  return self;
}


- (void) createDisplayForPlayers:(NSArray*)p {
  self.players = (NSMutableArray*)p;
  gameLayout = [[COSGameLayout alloc]initWithPlayers:p];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
	return YES;
}  


- (NSString*) defaultDeckPath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  return [documentsDirectory stringByAppendingString:@"/defaultDeck.txt"];
}


- (NSString*) lastDefaultDeck {
  if ([[NSFileManager defaultManager] fileExistsAtPath:[self defaultDeckPath]]) {  
    return [self defaultDeckPath];
  } else {
    return [[NSBundle mainBundle] pathForResource:@"farmer deck.txt" ofType:nil];
  }
}




- (void) startGame {
  NSString *fileString = @"";
  int i = 0;
  for (NSDictionary *cardDict in cardRegistry.cardList) {
    NSString *cardName = [cardDict objectForKey:@"name"];
    UIPickerView *picker = [deckBuilder.pickerIndex objectForKey:cardName];
    for (int x=0;x<[picker selectedRowInComponent:0];x++) {
      fileString = [fileString stringByAppendingFormat:@"%@\n",cardName];
      //NSLog(@"Writing string to file: %@", cardName);
    }
    i++;
  }
  //NSLog(@"Writing string to file: %@", fileString);
 // NSLog(@"Writing to file %@", [self defaultDeckPath]);
  
  if (![[NSFileManager defaultManager] fileExistsAtPath:[self defaultDeckPath]]) {
    [[NSFileManager defaultManager] createFileAtPath:[self defaultDeckPath] contents:nil attributes:nil];
  }
  
  NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self defaultDeckPath]];
  [fileHandle truncateFileAtOffset: 0];
    
  [fileHandle writeData:[fileString dataUsingEncoding:NSUTF8StringEncoding]];
  [fileHandle closeFile];
 
  [self dismissModalViewControllerAnimated:YES];
  
  // [(COSPlayer*)[players objectAtIndex:1]drawHand];
  COSPlayer *playerOne = [[[COSPlayer alloc]initWithDeck:[self defaultDeckPath] game:self]autorelease];
  COSPlayer *playerTwo = [[[COSPlayer alloc]initWithDeck:[self defaultDeckPath] game:self]autorelease];
  NSMutableArray *players = [NSMutableArray arrayWithObjects:playerOne, playerTwo, nil];  
  [self createDisplayForPlayers:players];
  [(COSPlayer*)[players objectAtIndex:0]drawHand];
  [self.view addSubview:gameLayout];
  gameLayout.frame = self.view.frame;


}


- (void) showDeckBuilder {
  NSString* filePath = [self lastDefaultDeck];
  deckBuilder = [[COSDeckBuilderTableView alloc]initWithRegistry:cardRegistry defaultDeckFile:filePath];
  deckBuilder.title = @"Deck Builder";
  UINavigationController *n = [[[UINavigationController alloc]initWithRootViewController:deckBuilder]autorelease];
  n.navigationBar.barStyle = UIBarStyleBlack;
  UIBarButtonItem *play = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(startGame)]autorelease];
  deckBuilder.navigationItem.rightBarButtonItem = play;
  [self presentModalViewController:n animated:NO];
  
}


@end

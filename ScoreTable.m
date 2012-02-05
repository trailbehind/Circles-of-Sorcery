//
//  ScoreTable.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreTable.h"
#import "COSScoreKeeper.h"
#import "COSConstants.h"
#import "COSTurnSummaryTableViewCell.h"

@implementation ScoreTable

- (void) dealloc {
  [scoreKeeper release];
  [super dealloc];
}


- (id) initWithScoreKeeper:(COSScoreKeeper*)keeper {
  self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
  scoreKeeper = [keeper retain];
  self.delegate = self;
  self.dataSource = self;
  return self;
}


- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return NUMBER_OF_TURNS;
  
}


- (COSTurnSummaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"ScoreCell";
  COSTurnSummaryTableViewCell *cell = (COSTurnSummaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
  if (cell == nil) {
    cell = [[[COSTurnSummaryTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
  }
  [cell setForScoreDict:scoreKeeper.scores turnNumber:indexPath.row];
	return cell;  
}


- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 30.0;
}


@end

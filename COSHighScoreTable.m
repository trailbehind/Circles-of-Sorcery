//
//  COSHighScoreTable.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSHighScoreTable.h"

@implementation COSHighScoreTable 

- (void) dealloc {
  [scoreList release];
  [super dealloc];
}


- (id) initWithScoreList:(NSArray*)list frame:(CGRect)frame showName:(BOOL)name {
  self = [super initWithFrame:frame style:UITableViewStylePlain];
  self.delegate = self;
  self.dataSource = self;
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  scoreList = [list retain];
  showName = name;
  return self;
}


- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"There are %d rows, %d for showName", [scoreList count], showName);
  return [scoreList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"HighScoreCell";
  UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    UIImageView *pointsIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star.png"]]autorelease];
    [cell.contentView addSubview:pointsIcon];		
    int imageSize = 24;
    pointsIcon.frame = CGRectMake(cell.contentView.frame.size.width - 55, 
                                  cell.contentView.frame.size.height/2-imageSize/2, 
                                  imageSize, 
                                  imageSize); 
  }
  if (showName) {
    cell.textLabel.text = [NSString stringWithFormat:@"#%d %@", indexPath.row+1, [[scoreList objectAtIndex:indexPath.row]objectForKey:@"name"]];
  } else {
    cell.textLabel.text = [NSString stringWithFormat:@"#%d", indexPath.row+1];
  }
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",
                               [[[scoreList objectAtIndex:indexPath.row]objectForKey:@"amount"]intValue]];
	return cell;  
}


- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0;
}


@end

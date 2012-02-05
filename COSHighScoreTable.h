//
//  COSHighScoreTable.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface COSHighScoreTable : UITableView <UITableViewDelegate, UITableViewDataSource> {
  BOOL showName;
  NSArray *scoreList;
}

- (id) initWithScoreList:(NSArray*)list frame:(CGRect)frame showName:(BOOL)name;


@end

//
//  COSDeckBuilderTableView.h
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSCardRegistry;

@interface COSDeckBuilderTableView : UITableViewController <UIPickerViewDelegate> {
  COSCardRegistry *registry;
  NSString *defaultDeckFile;
  NSMutableDictionary *defaultCounts;
  NSMutableArray *spinners;
  NSMutableDictionary *pickerIndex;
}

@property(nonatomic,retain)NSMutableArray *spinners;
@property(nonatomic,retain)NSMutableDictionary *pickerIndex;

- (id) initWithRegistry:(COSCardRegistry*)r defaultDeckFile:(NSString*)ddf;
- (NSDictionary*) defaultCounts;
@end

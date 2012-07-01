//
//  ViewController.h
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "DataCache.h"
@interface ViewController : UIViewController <UITableViewDelegate>
{
  IBOutlet UITableView *articleList;
  DetailViewController *articleView;
  NSMutableArray *articles;
  DataCache *cache;
  BOOL isEditing;
  IBOutlet UIButton *editingButton;
}
- (void)loadData;
- (IBAction)toggleEditMode:(id)sender;
@end

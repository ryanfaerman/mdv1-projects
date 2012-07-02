//
//  ViewController.h
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITabBarDelegate>
{
  IBOutlet UITableView *articleList;
  DetailViewController *articleView;
  NSMutableArray *articles;
  NSArray *categories;
  NSInteger *currentFilter;
  IBOutlet UITabBar *tabBar;
}
- (void)loadData;
- (NSArray*)dataForCategory:(NSInteger)category_id;
@end

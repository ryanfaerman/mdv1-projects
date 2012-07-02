//
//  ViewController.m
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"
#import "DetailViewController.h"
#import "SVPullToRefresh.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  // Get data from the server
  [self loadData];
  
  // pre-alloc the detail view
  articleView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
  currentFilter = 0;
  categories = [[NSArray alloc] initWithObjects:@"Announcement", @"Review", @"Preview", @"Editorial", @"Video", nil];
  
  [tabBar setSelectedItem:[tabBar.items objectAtIndex:(NSUInteger)currentFilter]];
  [articleList addPullToRefreshWithActionHandler:^{
    [self loadData];
    
  }];
  [super viewDidLoad];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)viewWillAppear:(BOOL)animated
{
  self.title = @"GameZone";
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Connect to a webservice (GameZone.com) and get the latest content
- (void)loadData
{
  NSError *err = nil;
  
  // Retrieve the data
  NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.gamezone.com/feeds/latest.json"]];
  
  // Deserialize the JSON into an immutable array
  NSArray *immutableArticles = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
  
  // make our articles a mutable array
  articles = [[NSMutableArray alloc] initWithArray:immutableArticles];
  [articleList.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}

- (NSArray*)dataForCategory:(NSInteger)category_id
{
  NSMutableArray *filtered_articles = [[NSMutableArray alloc] init];

  for (NSDictionary* article in articles) {
    if ([[article objectForKey:@"type"] isEqualToString:[categories objectAtIndex:category_id]]) {
      [filtered_articles addObject:article];
    }
  }
  
  return [[NSArray alloc] initWithArray:filtered_articles];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // one row per article
  return [[self dataForCategory:(NSInteger)currentFilter] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"cell";
  static BOOL nibsRegistered = NO;
  
  if (!nibsRegistered) {
    // no nibs have been registered yet, do that now.
    UINib *nib = [UINib nibWithNibName:@"CustomCellView" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
  }
  
  // dequeue the cell, it will auto-load the nib if it has never been loaded before
  CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  // get the article for the current row
  NSDictionary *article = [[self dataForCategory:(NSInteger)currentFilter] objectAtIndex:indexPath.row];
  
  // assign the row details
  cell.title = [article objectForKey:@"title"];
  cell.teaser = [article objectForKey:@"blurb"];
  cell.imageUrl = [article objectForKey:@"image"];
  
  // finally, return our prepared cell
  return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // get the article for the row
  NSDictionary *article = [[self dataForCategory:(NSInteger)currentFilter] objectAtIndex:indexPath.row];
  
  // set the content bits
  articleView.content = [article objectForKey:@"body"];
  //articleView.title = [article objectForKey:@"title"];
  
  
  // unselect the row, gets rid of the blue selection
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  // show the subview
  [self.navigationController pushViewController:articleView animated:YES];
  articleView.titleLabel.text = [article objectForKey:@"title"];
  [articleView.contentView loadHTMLString:[article objectForKey:@"body"] baseURL:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  
  currentFilter = (NSInteger *)item.tag;
  //[self loadData];
  [articleList reloadData];
}

@end

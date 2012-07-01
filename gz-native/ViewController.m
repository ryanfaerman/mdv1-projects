//
//  ViewController.m
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"
#import "DataCache.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  // Get data from the server
  [self loadData];
  
  // pre-alloc the detail view
  articleView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
  
  // by default, we're not editing
  isEditing = NO;
  
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // one row per article
  return [articles count];
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
  NSDictionary *article = [articles objectAtIndex:indexPath.row];
  
  // assign the row details
  cell.title = [article objectForKey:@"title"];
  cell.teaser = [article objectForKey:@"blurb"];
  cell.imageUrl = [article objectForKey:@"image"];
  
  // finally, return our prepared cell
  return cell;
}

- (IBAction)toggleEditMode:(id)sender
{ 
  // toggle our tracking BOOL
  isEditing = !isEditing;
  
  // Update the toggle button
  if (isEditing) {
    [editingButton setTitle:@"Done" forState:UIControlStateNormal];
  } else {
    [editingButton setTitle:@"Edit" forState:UIControlStateNormal];
  }
  
  // (de-)activate the edit state 
  [articleList setEditing:isEditing];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // get the article for the row
  NSDictionary *article = [articles objectAtIndex:indexPath.row];
  
  // set the content bits
  articleView.content = [article objectForKey:@"body"];
  articleView.title = [article objectForKey:@"title"];
  
  // unselect the row, gets rid of the blue selection
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  // show the subview
  [self presentModalViewController:articleView animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // every day i'm de-le-tin'
  return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // remove from the array and clear it from the table view
    [articles removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
  }
}

@end

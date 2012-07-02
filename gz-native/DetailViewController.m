//
//  DetailViewController.m
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize title;
@synthesize content;

@synthesize titleLabel;
@synthesize contentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      content = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setTitle:(NSString *)t
{
  if(![t isEqualToString:title])
  {
    // the title changed, so we set it and update the label
    title = [[t copy] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    titleLabel.text = title;
  }
}

- (void)setContent:(NSString *)c
{
  if(![c isEqualToString:content])
  {
    // the content changed, so we set it and set the HTML of the UIWebview
    content = [c copy];
    [contentView loadHTMLString:content baseURL:[NSURL URLWithString:@"http://www.gamezone.com"]];
  }
}

@end

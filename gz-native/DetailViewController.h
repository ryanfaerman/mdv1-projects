//
//  DetailViewController.h
//  gz-native
//
//  Created by Ryan Faerman on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIWebView *contentView;

- (IBAction)goBack:(id)sender;
@end

//
//  CustomTableCell.h
//  gz-native
//
//  Created by Ryan Faerman on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCache.h"
@interface CustomTableCell : UITableViewCell
{
  DataCache *cache;
}
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *teaser;
@property (copy, nonatomic) NSString *imageUrl;

@property (strong, nonatomic) IBOutlet UIImageView *articleImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *teaserTextView;

@end

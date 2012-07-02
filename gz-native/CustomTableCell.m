//
//  CustomTableCell.m
//  gz-native
//
//  Created by Ryan Faerman on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDNetworkActivityIndicator.h"

@implementation CustomTableCell

@synthesize title;
@synthesize imageUrl;
@synthesize teaser;

@synthesize titleLabel;
@synthesize articleImage;
@synthesize teaserTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)t
{
  if(![t isEqualToString:title])
  {
    // title changed, update the label
    title = [t copy];
    titleLabel.text = title;
  }
}

- (void)setImageUrl:(NSString *)i
{
  if(![i isEqualToString:imageUrl])
  {
    // url changed, do our magic
    
    imageUrl = [i copy];

    [articleImage setImageWithURL:[NSURL URLWithString:imageUrl]];
  }
}

- (void)setTeaser:(NSString *)t
{
  if(![t isEqualToString:teaser])
  {
    // teaser changed, assign the textview
    teaser = [[t copy] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    teaserTextView.text = teaser;
  }
}

@end

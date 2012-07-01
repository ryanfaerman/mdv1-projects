//
//  DataCache.h
//  gz-native
//
//  Created by Peter Mares on 15/11/2010.
//  Copyright 2010 Peter Mares. All rights reserved.
//  Updated by Ryan Faerman on June 28, 2012
//

#import <Foundation/Foundation.h>

@interface DataCache : NSObject
{
	NSString *documentsDirectory;
	NSString *cacheFileUrl;
	NSMutableDictionary *dictCache;
}

@property (nonatomic, retain) NSDictionary *dictCache;

+ (DataCache*) instance;

- (BOOL) isRemoteFileCached:(NSString*)url;
- (NSData*) getCachedRemoteFile:(NSString*)url;
- (BOOL) addRemoteFileToCache:(NSString*)url withData:(NSData*)data;

@end

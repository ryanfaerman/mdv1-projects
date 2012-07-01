//  DataCache.h
//  gz-native
//
//  Created by Peter Mares on 15/11/2010.
//  Copyright 2010 Peter Mares. All rights reserved.
//  Updated by Ryan Faerman on June 28, 2012
//

#import "DataCache.h"
#define kDefaultCacheFile @"datacache.plist"

@interface DataCache (private)
- (NSString*) makeKeyFromUrl:(NSString*)url;
@end//private DataCache interface

// This is going to be a singleton
static DataCache *sharedInstance = nil;


@implementation DataCache
@synthesize dictCache;

- (id)init
{
	if ( (self = [super init]) )
	{
		// prepare the cache
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		
		documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
		
		// the path to the cache map
		cacheFileUrl = [documentsDirectory stringByAppendingPathComponent:kDefaultCacheFile];
    
		dictCache = [[NSMutableDictionary alloc] initWithContentsOfFile:cacheFileUrl];
		
		if ( dictCache == nil )
		{
			dictCache = [[NSMutableDictionary alloc] init];
		}
	}
	
	return self;
}


+ (DataCache*) instance
{
	@synchronized(self)
	{
		if ( sharedInstance == nil )
		{
      // never seen before, init
			sharedInstance = [[DataCache alloc] init];
		}
	}
	return sharedInstance;
}



- (BOOL) isRemoteFileCached:(NSString*)url
{
  // determine existence
	NSString *imageFilename = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	
	return (imageFilename != nil);
}


- (NSData*) getCachedRemoteFile:(NSString*)url
{
  // pull from cache
	NSString *imageFilename = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	NSData *data = nil;
	
	if ( imageFilename != nil )
	{
		data = [NSData dataWithContentsOfFile:imageFilename];
	}
	
	return data;
}


- (BOOL) addRemoteFileToCache:(NSString*)url withData:(NSData*)data
{
	BOOL result = NO;
	NSString *imageFilename = [url lastPathComponent];
	
	if ( imageFilename != nil )
	{
		// the path to the cached image file
		NSString *cachedImageFileUrl = [documentsDirectory stringByAppendingPathComponent:imageFilename];
    
		result = [data writeToFile:cachedImageFileUrl atomically:YES];
		
		if ( result == YES )
		{
			// add the cached file to the dictionary
			[dictCache setValue:cachedImageFileUrl forKey:[self makeKeyFromUrl:url]];
			[dictCache writeToFile:cacheFileUrl atomically:YES];
		}
	}
	
	return result;
}

#pragma mark -
#pragma mark Private Methods

- (NSString*) makeKeyFromUrl:(NSString*)url
{
	NSString *key = [url stringByReplacingOccurrencesOfString:@"/" withString:@"."];
  
	key = [key stringByReplacingOccurrencesOfString:@":" withString:@"."];
	return key;
}

@end

//
//  Cache.m
//  NavigationView
//
//  Created by Syed Sajid Nizami on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"


@implementation ImageCache

+ (NSString *) getFileName: (NSString *) url forDuration:(CacheDuration) duration{
	NSString * path = nil;

	switch ((int)duration) {
		case Keep:
			path = [NSString stringWithFormat:@"/Library/Caches/Images/%@",@"Keep"];
			break;
		case OneWeek:
			path = [NSString stringWithFormat:@"/tmp/%@",@"OneWeek"];
			break;
		case OneMonth:
			path = [NSString stringWithFormat:@"/tmp/%@",@"OneMonth"];
			break;
		case Temp:
		default:
			path = [NSString stringWithFormat:@"/tmp/%@",@"Temp"];
			break;
	}
	
	path = [[[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:path];
	[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
	
	NSString * filename = [[url componentsSeparatedByString:@"/"] lastObject];
	filename = [path stringByAppendingFormat:@"/%@", filename];
	return filename;
}

+ (UIImage *) getImage:(NSString *) url andSet:(UIImageView *) placeholder {
	return [ImageCache getImage:url andSet:placeholder forDuration:Temp];
}

+ (UIImage *) getImage:(NSString *) url andSet:(UIImageView *) placeholder forDuration:(CacheDuration) duration{
	NSString * filename = [ImageCache getFileName:url forDuration:duration];
	UIImage * image = [UIImage imageWithContentsOfFile:filename];
	if (image == NULL) {
		NSMutableArray * temp = [[NSMutableArray alloc] init];
		[temp addObject:url];
		[temp addObject:placeholder];
		[temp addObject:filename];
		[self performSelectorInBackground:@selector(loadImage:) withObject:temp];
	};
	
	placeholder.image = image;
	return image;
}

+ (void) loadImage:(NSArray *) input {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString * url = [input objectAtIndex:0];
	UIImageView * placeholder = [input objectAtIndex:1];
	NSString * filename = [input objectAtIndex:2];
	
	UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
	[UIImageJPEGRepresentation(image, 0.5) writeToFile:filename atomically:YES];
	
	if(image != NULL){
		placeholder.image = image;
	}
	
	[pool release];
}

@end

//
//  ImageCache.h
//  NavigationView
//
//  Created by Syed Sajid Nizami on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum CacheFor {
	Keep,
	OneWeek,
	OneMonth,
	Temp
} CacheDuration;


@interface ImageCache : NSObject {
@public

}

+ (void) loadImage:(NSArray *) input;

+ (NSString *) getFileName: (NSString *) url forDuration:(CacheDuration) duration;
+ (UIImage *) getImage:(NSString *) url andSet:(UIImageView *) placeholder forDuration:(CacheDuration) duration;
+ (UIImage *) getImage:(NSString *) url andSet:(UIImageView *) placeholder;



@end

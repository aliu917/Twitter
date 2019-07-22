//
//  Helper.h
//  twitter
//
//  Created by aliu18 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Helper : NSObject

+(NSURL *) makeURLWithString: (NSString *) pictureStringURL;
+ (void) initializeRetweet:(UIButton *)retweet andLike:(UIButton *)like forTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END

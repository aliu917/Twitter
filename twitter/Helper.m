//
//  Helper.m
//  twitter
//
//  Created by aliu18 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Helper.h"
#import <UIKit/UIKit.h>
#import "Tweet.h"

@implementation Helper

+(NSURL *) makeURLWithString: (NSString *) pictureStringURL {
    NSString *profilePictureURL = pictureStringURL;
    NSURL *pictureURL = [NSURL URLWithString:profilePictureURL];
    return pictureURL;
}

+ (void) initializeRetweet:(UIButton *)retweet andLike:(UIButton *)like forTweet:(Tweet *)tweet {
    if (tweet.favorited) {
        [like setSelected:YES];
    }
    if (tweet.retweeted) {
        [retweet setSelected:YES];
    }
    [retweet setImage: [UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [retweet setImage: [UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [like setImage: [UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [like setImage: [UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
}


@end

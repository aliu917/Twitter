//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by aliu18 on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) UIViewController *timeline;

@end

NS_ASSUME_NONNULL_END

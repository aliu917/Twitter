//
//  ComposeViewController.h
//  twitter
//
//  Created by aliu18 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate;

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (strong, nonatomic) Tweet *replyTweet;

@end

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END

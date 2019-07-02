//
//  TweetCell.h
//  twitter
//
//  Created by aliu18 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetMessage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END

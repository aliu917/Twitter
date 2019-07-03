//
//  TweetCell.m
//  twitter
//
//  Created by aliu18 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "Helper.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

# pragma mark - TweetCell Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Action: Tapped like button

- (IBAction)didTapLike:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    [self refreshData];
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

# pragma mark - TweetCell Helper Functions

-(void)refreshData {
    [self.retweetButton setImage: [UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
     [self.retweetButton setImage: [UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
     [self.likeButton setImage: [UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
     [self.likeButton setImage: [UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
}

@end

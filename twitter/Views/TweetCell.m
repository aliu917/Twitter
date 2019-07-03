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

#pragma mark - TweetCell Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setTweet: (Tweet *) tweet {
    
    
    _tweet = tweet;
    self.username.text = self.tweet.user.name;
    self.tweetMessage.text = self.tweet.text;
    self.atUsername.text = self.tweet.user.screenName;
    self.dateLabel.text = self.tweet.createdAtString;
    NSURL *imageURL = [Helper makeURLWithString: self.tweet.user.profileImage];
    [self.profileImage setImageWithURL:imageURL];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Action: Tapped like button

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited) {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                [self.likeButton setSelected:NO];
                self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
            }
        }];
    } else {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                [self.likeButton setSelected:YES];
                self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
            }
        }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                self.tweet.retweeted = NO;
                self.tweet.retweetCount -= 1;
                [self.retweetButton setSelected:NO];
                self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
            }
        }];
    } else {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet.retweeted = YES;
                self.tweet.retweetCount += 1;
                [self.retweetButton setSelected:YES];
                self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
            }
        }];
    }
}

#pragma mark - TweetCell Helper Functions

/*-(void)updateButtonImage {
    [self.retweetButton setImage: [UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage: [UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [self.likeButton setImage: [UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.likeButton setImage: [UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
}*/

@end

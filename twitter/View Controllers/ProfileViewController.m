//
//  ProfileViewController.m
//  twitter
//
//  Created by aliu18 on 7/21/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"
#import "Tweet.h"
#import "TweetDetailsViewController.h"

@interface ProfileViewController () //<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *atUsername;
@property (weak, nonatomic) IBOutlet UILabel *bio;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (self.user == nil) {
        [self getUser];
    } else {
        [self setupViews];
    }
}

#pragma mark - UITableView delegate & data source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //[self.tableView registerClass:[TweetCell class] forCellReuseIdentifier:@"TweetCell"];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    //cell = [[TweetCell alloc] initWithTweet:tweet];
    [cell setTweet:tweet];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tweets) {
        return self.tweets.count;
    }
    return 0;
}

#pragma mark - ProfileViewController Helper functions

- (void)getUser {
    [[APIManager shared] getUserWithCompletion:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            [self setupViews];
        } else {
            NSLog(@"Error getting user: %@", error.localizedDescription);
        }
    }];
}

- (void)fetchUserTimeline {
    [[APIManager shared] getUserTimeline:self.user.userID WithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting user: %@", error.localizedDescription);
        }
    }];
}

- (void)setupViews {
    NSURL *imageURL = [Helper makeURLWithString: self.user.profileImage];
    [self.profileImage setImageWithURL:imageURL];
    NSURL *backgroundURL = [Helper makeURLWithString: self.user.backgroundImage];
    [self.backgroundImage setImageWithURL:backgroundURL];
    self.username.text = self.user.name;
    self.atUsername.text = self.user.screenName;
    self.bio.text = self.user.bio;
    [self fetchUserTimeline];
}


 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     TweetCell *tappedCell = sender;
     TweetDetailsViewController *tweetDetailsViewController = [segue destinationViewController];
     tweetDetailsViewController.tweet = tappedCell.tweet;
 }

@end

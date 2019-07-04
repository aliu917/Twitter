//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "Helper.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetDetailsViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

#pragma mark - TimelineViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Get timeline
    [self fetchTweets];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview: self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
        
    [cell setTweet: self.tweets[indexPath.row]];
    
    /*
    cell.username.text = tweet.user.name;
    cell.tweetMessage.text = tweet.text;
    cell.atUsername.text = tweet.user.screenName;
    cell.dateLabel.text = tweet.createdAtString;
    NSURL *imageURL = [Helper makeURLWithString: tweet.user.profileImage];
    [cell.profileImage setImageWithURL:imageURL];*/
    
    
    //maybe like a refresh button method in the helper later???
    
    
    [cell.retweetButton setImage: [UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [cell.retweetButton setImage: [UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [cell.likeButton setImage: [UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [cell.likeButton setImage: [UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    
    //^^^for this ugly chunk right here...
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

#pragma mark - Update adding tweets

- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweets addObject: tweet];
    [self.tableView reloadData];
}

#pragma mark - Action: logging out

- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

#pragma mark - TimelineViewController helper functions

- (void)fetchTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

/*-(NSURL *) makeURLWithString: (NSString *) pictureStringURL {
 NSString *profilePictureURL = pictureStringURL;
 NSURL *pictureURL = [NSURL URLWithString:profilePictureURL];
 return pictureURL;
 }*/

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"detailSegue"]) {
         TweetCell *tappedCell = sender;
         //NSIndexPath *indexPath = [self.tableView indexPathForCell: tappedCell];
         //Tweet *tweet = self.tweets[indexPath.row];
         TweetDetailsViewController *tweetDetailsViewController = [segue destinationViewController];
         //tweetDetailsViewController.tweet = tweet;
         tweetDetailsViewController.tweet = tappedCell.tweet;
     } else {
         UINavigationController *navigationController = [segue destinationViewController];
         ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
         composeController.delegate = self;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }



@end

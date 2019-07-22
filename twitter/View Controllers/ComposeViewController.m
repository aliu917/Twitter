//
//  ComposeViewController.m
//  twitter
//
//  Created by aliu18 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *composedTweet;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@end

@implementation ComposeViewController

#pragma mark - ComposeViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.replyTweet) {
        self.replyLabel.text = [NSString stringWithFormat:@"Replying to %@", self.replyTweet.user.screenName];
    } else {
        self.replyLabel.alpha = 0;
    }
}

#pragma mark - Action: close new tweet screen

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Action: create new tweet

/*- (IBAction)createTweet:(id)sender {
    [[APIManager shared] postStatusWithText: self.composedTweet.text completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            [self dismissViewControllerAnimated:true completion:nil];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}*/

- (IBAction)didTapTweet:(id)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (self.replyTweet) {
        [param setObject:self.replyTweet.idStr forKey:@"in_reply_to_status_id"];
        NSString *addSpace = [self.replyTweet.user.screenName stringByAppendingString:@" "];
        self.composedTweet.text = [addSpace stringByAppendingString:self.composedTweet.text];
    }
    [param setObject:self.composedTweet.text forKey:@"status"];
    [[APIManager shared]postStatusWithParam:param completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

/*- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared]postStatusWithText:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}*/


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

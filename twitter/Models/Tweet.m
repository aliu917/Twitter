//
//  Tweet.m
//  twitter
//
//  Created by aliu18 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

#pragma mark - Tweet initiation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        self.createdAtString = [self formatDate: dictionary];
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

#pragma mark - Tweet Helper Functions

-(NSString *) formatDate: (NSDictionary *) dictionary {
    NSString *createdAtOriginalString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *convertedDate = [formatter dateFromString:createdAtOriginalString];
    //[df release];
    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"never";
    } else  if (ti < 60) {
        return @"less than a minute ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d min ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hours ago", diff];
    } else if (ti < 2629743) {
        //int diff = round(ti / 60 / 60 / 24);
        //return[NSString stringWithFormat:@"%d days ago", diff];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        return [formatter stringFromDate:convertedDate];
        //return self.createdAtString;
    } else {
        return @"never";
    }
    
    
    /*[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];

    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    return [formatter stringFromDate:date];*/
}

/*-(NSString *)dateDiff:(NSString *)origDate {
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *convertedDate = [df dateFromString:origDate];
    //[df release];
    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"never";
    } else  if (ti < 60) {
        return @"less than a minute ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d minutes ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hours ago", diff];
    } else if (ti < 2629743) {
        //int diff = round(ti / 60 / 60 / 24);
        //return[NSString stringWithFormat:@"%d days ago", diff];
        return self.createdAtString;
    } else {
        return @"never";
    }
}*/

@end

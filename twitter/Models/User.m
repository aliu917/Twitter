//
//  User.m
//  twitter
//
//  Created by aliu18 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - User initiation

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = [self makeScreenName:dictionary];
        self.profileImage = dictionary[@"profile_image_url_https"];
        self.bio = dictionary[@"description"];
        self.backgroundImage = dictionary[@"profile_banner_url"];
        self.rawScreenName = dictionary[@"screen_name"];
        self.userID = dictionary[@"id_str"];
    }
    return self;
}

#pragma mark - User Helper Functions

-(NSString *) makeScreenName: (NSDictionary *) dictionary {
    NSString *atSymbol = @"@";
    NSString *profileName = dictionary[@"screen_name"];
    NSString *screenName = [atSymbol stringByAppendingString: profileName];
    return screenName;
}

@end

//
//  User.m
//  twitter
//
//  Created by aliu18 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        NSString *atSymbol = @"@";
        NSString *profileName = dictionary[@"screen_name"];
        NSString *screenName = [atSymbol stringByAppendingString: profileName];
        self.screenName = screenName;
        self.profileImage = dictionary[@"profile_image_url_https"];
        //initialize any other properties
    }
    return self;
}

@end

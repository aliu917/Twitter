//
//  ProfileCell.m
//  twitter
//
//  Created by aliu18 on 7/21/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithUser:(User *) user {
    self = [super init];
    _user = user;
    NSURL *imageURL = [Helper makeURLWithString: self.user.profileImage];
    [self.profileImage setImageWithURL:imageURL];
    NSURL *backgroundURL = [Helper makeURLWithString: self.user.backgroundImage];
    [self.backgroundImage setImageWithURL:backgroundURL];
    self.username.text = self.user.name;
    self.atUsername.text = self.user.screenName;
    self.bio.text = self.user.bio;
    return self;
}

@end

//
//  Helper.m
//  twitter
//
//  Created by aliu18 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+(NSURL *) makeURLWithString: (NSString *) pictureStringURL {
    NSString *profilePictureURL = pictureStringURL;
    NSURL *pictureURL = [NSURL URLWithString:profilePictureURL];
    return pictureURL;
}

@end

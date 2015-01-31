//
//  CSUser.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSUser.h"
@interface CSUser()
@property (nonatomic,strong) NSString* userFName;
@property (nonatomic,strong) NSString* userLName;
@end

@implementation CSUser

- (void) setUserFNameTo : (NSString *) userfname
         andUserLNameTo : (NSString *) userlname
{
    self.userFName = [NSString stringWithString:userfname];
    self.userLName = [NSString stringWithString:userlname];
}

-(NSString *) sendFname
{
    return self.userFName;
}
-(NSString *) sendLname
{
    return self.userLName;
}

/*-(CSUser *)thisUser
{
    if(_thisUser == nil)
        _thisUser = [[CSUser alloc] init];
    return _thisUser;
}
*/


@end

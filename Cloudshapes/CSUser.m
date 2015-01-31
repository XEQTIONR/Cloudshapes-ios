//
//  CSUser.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSUser.h"
@interface CSUser()

@end

@implementation CSUser

static CSUser *sharedCSUser = nil;

+(CSUser *)currentAppUser
{
    if (sharedCSUser == nil)
    {
        sharedCSUser = [[super alloc] init];
    }
    return sharedCSUser;
}

-(id) init
{
    if (self = [super init]) //??? Look this up to be sure
    {
        NSUserDefaults *globalAppDefaults = [[NSUserDefaults alloc] init];
        [self setUserFName:[globalAppDefaults objectForKey:@"userfname"]];
        [self setUserLName:[globalAppDefaults objectForKey:@"userlname"]];
        [self setUserName:[globalAppDefaults objectForKey:@"userdisplayname"]];
        [self setUserPoints:[globalAppDefaults objectForKey:@"userpoints"]];
        //self setUserFName:
        //dummy initialization
       // [self setUserFNameTo:@"Icky" andUserLNameTo:@"Vicky"];
    }
    return self;
}
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

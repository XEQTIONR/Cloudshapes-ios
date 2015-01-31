//
//  CSUser.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUser : NSObject

//@property (nonatomic) NSInteger *userId;
+(CSUser *)currentAppUser;
-(void) setUserFNameTo : (NSString *)userfname
        andUserLNameTo : (NSString *)userlname;

-(NSString *) sendFname;
-(NSString *) sendLname;
@end
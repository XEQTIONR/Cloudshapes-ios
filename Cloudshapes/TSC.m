//
//  TSC.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-29.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "TSC.h"

@interface TSC()

@property (nonatomic, strong)NSString *string;
@property (nonatomic, strong)NSString *string2;
@end

@implementation TSC

-(void) setString1To:(NSString *)paramString1 andString2To:(NSString *)paramString2
{
    self.string = paramString1;
    self.string2 = paramString2;
}
@end

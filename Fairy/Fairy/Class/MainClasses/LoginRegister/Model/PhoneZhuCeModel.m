//
//  PhoneZhuCeModel.m
//  Fairy
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "PhoneZhuCeModel.h"

@implementation PhoneZhuCeModel

/**
 *  此方法的作用是需要存储对象的哪些属性以及怎样存储
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.token forKey:@"token"];
//    [aCoder encodeObject:self.profile forKey:@"profile"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
   
        self.token =[aDecoder decodeObjectForKey:@"token"];
//        self.profile =[aDecoder decodeObjectForKey:@"profile"];
    }
    return self;
}


@end

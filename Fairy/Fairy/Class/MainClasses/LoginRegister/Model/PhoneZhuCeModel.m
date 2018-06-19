//
//  PhoneZhuCeModel.m
//  Fairy
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PhoneZhuCeModel.h"

@implementation PhoneZhuCeModel

/**
 *  此方法的作用是需要存储对象的哪些属性以及怎样存储
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.salt forKey:@"salt"];
    [aCoder encodeObject:self.autoKey forKey:@"autoKey"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.profile forKey:@"profile"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userId =[aDecoder decodeObjectForKey:@"userId"];
        self.salt =[aDecoder decodeObjectForKey:@"salt"];
        self.autoKey =[aDecoder decodeObjectForKey:@"autoKey"];
        self.mobile =[aDecoder decodeObjectForKey:@"mobile"];
        self.pwd =[aDecoder decodeObjectForKey:@"pwd"];
        self.profile =[aDecoder decodeObjectForKey:@"profile"];
    }
    return self;
}


@end

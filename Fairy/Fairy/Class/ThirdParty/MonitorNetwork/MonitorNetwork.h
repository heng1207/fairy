//
//  MonitorNetwork.h
//  zhcxuser
//
//  Created by orilme on 2017/9/11.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@protocol ReachabilityDelegate <NSObject>
-(void)HcltButtonDelegateAction:(int)a;//网络改变是触发



@end

@interface MonitorNetwork : NSObject
@property(nonatomic, strong) Reachability     *hostReach;
@property(nonatomic)BOOL       isReachable;
@property(nonatomic,strong)void(^block)(BOOL open);
@property (nonatomic , weak) id <ReachabilityDelegate> delegate;
+(instancetype)defultMonitor;
-(void)DealF;
-(NSString *)panDuan;
@end


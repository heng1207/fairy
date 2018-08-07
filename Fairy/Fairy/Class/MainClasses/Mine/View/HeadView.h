//
//  HeadView.h
//  Fairy
//
//  Created by iOS-Mac on 2018/8/7.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>
-(void)headViewLoginTapClick;
@end

@interface HeadView : UIView

@property(nonatomic,weak)id<HeadViewDelegate> delegate;

@end

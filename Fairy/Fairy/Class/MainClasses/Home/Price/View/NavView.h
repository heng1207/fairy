//
//  NavView.h
//  Fairy
//
//  Created by  on 2018/7/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol navViewDelegate <NSObject>
-(void)navViewSearch:(NSString *)searchStr;
-(void)navViewback;
@end

@interface NavView : UIView
@property(nonatomic,weak)id<navViewDelegate> delegate;
@end

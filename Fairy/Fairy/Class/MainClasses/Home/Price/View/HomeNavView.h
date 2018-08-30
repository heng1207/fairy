//
//  NavView.h
//  Fairy
//
//  Created by  on 2018/7/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol navViewDelegate <NSObject>
-(void)navViewSearch;

@end


@interface HomeNavView : UIView


@property(nonatomic,weak)id<navViewDelegate> delegate;

@end

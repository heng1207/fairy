//
//  BaseTypeView.h
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTypeViewDelegate <NSObject>

- (void)gmdOpFenXiClick;
- (void)gmdOpYuCeClick;
- (void)gmdOpYuJingClick;

@end
@interface BaseTypeView : UIView

@property (nonatomic, weak) id<BaseTypeViewDelegate> delegate;
@end

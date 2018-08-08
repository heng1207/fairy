//
//  IndexTypeView.h
//  Fairy
//
//  Created by iOS-Mac on 2018/8/8.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexTypeViewDelegate <NSObject>
-(void)indexTypeViewTypeSelect:(NSInteger)typeSelect;
@end

@interface IndexTypeView : UIView

@property(nonatomic,weak) id<IndexTypeViewDelegate> delegate;

@end

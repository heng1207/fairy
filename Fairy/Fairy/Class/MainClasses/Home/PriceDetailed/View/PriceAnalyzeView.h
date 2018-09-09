//
//  PriceAnalyzeView.h
//  Fairy
//
//  Created by iOS-Mac on 2018/8/6.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLPictureBrowseView.h"

@interface PriceAnalyzeView : UIView //行情分析

-(instancetype)initWithFrame:(CGRect)frame FenXi:(NSString *)fenXi;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)UIImageView *describeIM;
@property(nonatomic,strong)NSString *imageurl;


@end

//
//  PriceAnalyzeView.h
//  Fairy
//
//  Created by iOS-Mac on 2018/8/6.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceAnalyzeView : UIView

-(instancetype)initWithFrame:(CGRect)frame FenXi:(NSString *)fenXi;
@property(nonatomic,strong)NSMutableDictionary *dataDic;


@end

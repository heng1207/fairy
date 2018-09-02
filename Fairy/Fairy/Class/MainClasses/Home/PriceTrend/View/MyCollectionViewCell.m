//
//  MyCollectionViewCell.m
//  Fairy
//
//  Created by 张恒 on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property(nonatomic,strong)UILabel *botlabel;

@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel* botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.botlabel = botlabel;
        botlabel.textAlignment = NSTextAlignmentCenter;
        botlabel.textColor = [UIColor blackColor];
        botlabel.font = [UIFont systemFontOfSize:15];
        botlabel.backgroundColor = [UIColor colorWithHex:@"#f2f2f2"];
        [self.contentView addSubview:botlabel];
        
    }
    return self;
}

-(void)setModel:(PriceModel *)model{
    _model = model;
    self.botlabel.text = model.fsym;
}


@end

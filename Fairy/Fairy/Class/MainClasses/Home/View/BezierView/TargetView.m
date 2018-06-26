//
//  TargetView.m
//  BezierLine
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TargetView.h"

#define MARGIN_Top             5   //上间隔
#define MARGIN_Bottom          15   //下间隔

@interface TargetView ()

@property(nonatomic,assign) CGRect myFrame;

@property(nonatomic,assign)float space_y; //Y轴间隔宽

@end


@implementation TargetView

-(instancetype)initWithFrame:(CGRect)frame WithY_Value_Names:(NSMutableArray *)y_names{
    self = [super initWithFrame:frame];
    if (self) {
        self.myFrame = frame;
        
        [self drawYLine:y_names];
    }
    return self;
}

/**
 *  画坐标轴
 */
-(void)drawYLine:(NSMutableArray *)y_names{
    
    self.space_y = (CGRectGetHeight(self.myFrame) - MARGIN_Top - MARGIN_Bottom)/ (y_names.count-1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width-1, CGRectGetHeight(self.myFrame)-MARGIN_Bottom)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-1, MARGIN_Top)];
    
    
    //Y轴
    for (int i=0; i<y_names.count; i++) {
        CGFloat Y = CGRectGetHeight(self.myFrame)-MARGIN_Bottom-self.space_y*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.myFrame)-24, Y-5, 20, 10)];
        textLabel.text = [NSString stringWithFormat:@"%@",y_names[i]];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentRight;
        textLabel.textColor = [UIColor blackColor];
        [self addSubview:textLabel];
    }

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

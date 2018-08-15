//
//  TLTextView.m
//
//  Created by 唐丽 on 14-10-20.
//  Copyright (c) 2014年 itcase. All rights reserved.
//

#import "TLTextView.h"

#import "UIView+Addition.h"


@implementation TLTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 通知,当文本框的文字改变时，会自动发出一个通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 当文本框的文字发生变化时，就重新渲染一次
- (void)textChange
{
    [self setNeedsDisplay];
}

// 当self的font发生改变时也要重新渲染一次
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

// 当用代码设置文本框的文字时也要重新渲染一次
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

// 当设置文本框属性文字时也要重新渲染一次
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

// 当设置占位文字的颜色时也要重新渲染一次
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = [placeholderColor copy];
    
    [self setNeedsDisplay];
}

// 当设置占位文字内容时也要重新渲染一次
- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = [placeholderText copy];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.hasText)   return;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = self.font?self.font:[UIFont fontWithName:@"SourceHanSansCN-Normal" size:16];
    dic[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    
    CGFloat placeholderTextX = 0;
    CGFloat placeholderTextY = 8;
    CGFloat placeholderTextW = self.width - 2 * placeholderTextX;
    CGFloat placeholderTextH = self.height - 2 * placeholderTextY;
    [self.placeholderText drawInRect:CGRectMake(placeholderTextX, placeholderTextY, placeholderTextW, placeholderTextH) withAttributes:dic];
}



//TextView/TextField自定义光标长度或高度, 可通过重写父类方法caretRectForPosition:实现, 具体设置如下:
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    
    originalRect.size.height = self.font.lineHeight + 4;
    originalRect.size.width = 1;
    
    return originalRect;
}



@end

//
//  MessageCell.h
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *DetailsLab;
@property (weak, nonatomic) IBOutlet UIImageView *JianTouIM;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

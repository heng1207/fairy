//
//  InformationCell.h
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationFrameModel.h"
#import "InformationTimeModel.h"
#import "InformationModel.h"

@class InformationCell;
@protocol InformationCellDelegate <NSObject>
-(void)urlclick:(InformationCell*)informationCellCell;

@end


@interface InformationCell : UITableViewCell

@property(nonatomic,strong)InformationFrameModel *informationFrameModel;
@property(nonatomic,strong)InformationTimeModel *informationTimeModel;
@property(nonatomic,strong)InformationModel *informationModel;

@property(nonatomic,weak)id<InformationCellDelegate> delegate;

@end

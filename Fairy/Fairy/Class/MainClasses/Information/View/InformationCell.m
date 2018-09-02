//
//  InformationCell.m
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "InformationCell.h"
#import "ProgresView.h"


@interface InformationCell()

@property(nonatomic,strong)UIView *sectionView;
@property(nonatomic,strong)UILabel *allTimeLab;
@property(nonatomic,strong)UILabel *hourLab;
@property(nonatomic,strong)UILabel *keyLab;
@property(nonatomic,strong)UILabel *sentimentLab;
@property(nonatomic,strong)ProgresView *progresView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *line;


@end

@implementation InformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /// 初始化cell的子控件
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    
    UIView *sectionView =[UIView new];
    sectionView.backgroundColor = [UIColor colorWithHex:@"#e9eff8"];
    _sectionView = sectionView;
    [self.contentView addSubview:sectionView];
    
    /// 分区时间
    UILabel *allTimeLab = [[UILabel alloc] init];
    allTimeLab.backgroundColor =[UIColor colorWithHex:@"#e9eff8"];
    allTimeLab.textColor = [UIColor grayColor];
    allTimeLab.font = [UIFont systemFontOfSize:15];
    allTimeLab = allTimeLab;
    _allTimeLab = allTimeLab;
    [self.contentView addSubview:allTimeLab];

    
    
    /// hour
    UILabel *hourLab = [[UILabel alloc] init];
    hourLab.textColor = [UIColor colorWithHex:@"#1296db"];
    hourLab.font = [UIFont systemFontOfSize:15];
    _hourLab = hourLab;
    [self.contentView addSubview:hourLab];
    

    /// key
    UILabel *keyLab = [[UILabel alloc] init];
    keyLab.textColor = [UIColor grayColor];
    keyLab.font = [UIFont systemFontOfSize:15];
    _keyLab = keyLab;
    [self.contentView addSubview:keyLab];
    
    /// sentiment
    UILabel *sentimentLab = [[UILabel alloc] init];
    sentimentLab.textColor = [UIColor grayColor];
    sentimentLab.font = [UIFont systemFontOfSize:12];
    _sentimentLab = sentimentLab;
    [self.contentView addSubview:sentimentLab];
    
    
    //进度条
    ProgresView *progresView =[[ProgresView alloc]init];
    _progresView = progresView;
    [self.contentView addSubview:progresView];
    
    
    
    /// title
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.numberOfLines = 0;
    _titleLab = titleLab;
    [self.contentView addSubview:titleLab];
    
    

    //分割线
    UIView *line =[UIView new];
    _line = line;
    line.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.contentView addSubview:line];
    
}
-(void)setInformationFrameModel:(InformationFrameModel *)informationFrameModel{
    _informationFrameModel = informationFrameModel;
    _informationTimeModel = informationFrameModel.informationTimeModel;
    _informationModel = _informationTimeModel.informationModel;

    
    _sectionView.frame =_informationFrameModel.sectionF;
    
    _allTimeLab.text = _informationTimeModel.allTime;
    _allTimeLab.frame = _informationFrameModel.allTime;
    
    
    _hourLab.text =_informationTimeModel.hourTime;
    _hourLab.frame = _informationFrameModel.hourTime;
    
    _keyLab.text =_informationModel.key;
    _keyLab.frame = _informationFrameModel.keyF;
    
    NSString *sentimentStr;
    BOOL isInt = [Tool isPureInt:_informationModel.sentiment];
    if (isInt) {
        sentimentStr = [NSString stringWithFormat:@"%@.0",_informationModel.sentiment];
    }
    else{
        float change = [_informationModel.sentiment floatValue];
        sentimentStr = [NSString stringWithFormat:@"%0.2f",change];
    }
    _sentimentLab.text = sentimentStr;
    _sentimentLab.frame = _informationFrameModel.sentimentF;
    
    
    _progresView.frame = _informationFrameModel.progressF;
    _progresView.progress = [_informationModel.sentiment floatValue];
    
    _titleLab.text =_informationModel.title;
    _titleLab.frame = _informationFrameModel.titleF;
    
    
    _line.frame = _informationFrameModel.lineF;
    
    
}

-(void)urlLabTap:(UITapGestureRecognizer*)urlTap{
    
    if (_delegate && [_delegate respondsToSelector:@selector(urlclick:)]) {
        [_delegate urlclick:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

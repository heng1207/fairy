//
//  InformationCell.m
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell()

@property(nonatomic,strong)UILabel *keyLab;
@property(nonatomic,strong)UILabel *sentimentLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *urlLab;
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
    /// key
    UILabel *keyLab = [[UILabel alloc] init];
    keyLab.textColor = [UIColor blackColor];
    keyLab.font = [UIFont systemFontOfSize:15];
    _keyLab = keyLab;
    [self.contentView addSubview:keyLab];
    
    /// sentiment
    UILabel *sentimentLab = [[UILabel alloc] init];
    sentimentLab.textColor = [UIColor blackColor];
    sentimentLab.font = [UIFont systemFontOfSize:15];
    _sentimentLab = sentimentLab;
    [self.contentView addSubview:sentimentLab];
    
    /// title
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.numberOfLines = 0;
    _titleLab = titleLab;
    [self.contentView addSubview:titleLab];
    
    /// url
    UILabel *urlLab = [[UILabel alloc] init];
    urlLab.textColor = [UIColor blueColor];
    urlLab.font = [UIFont systemFontOfSize:15];
    _urlLab = urlLab;
    _urlLab.numberOfLines = 0;
    _urlLab.userInteractionEnabled =YES;
    [self.contentView addSubview:urlLab];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(urlLabTap:)];
    [_urlLab addGestureRecognizer:tap];
    
    
    
    
    //分割线
    UIView *line =[UIView new];
    _line = line;
    line.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.contentView addSubview:line];
    
}
-(void)setInformationFrameModel:(InformationFrameModel *)informationFrameModel{
    _informationFrameModel = informationFrameModel;
    _informationModel = informationFrameModel.informationModel;
    
    
    _keyLab.text =_informationModel.key;
    _keyLab.frame = _informationFrameModel.keyF;
    
    NSString *sentimentStr;
    BOOL isInt = [Tool isPureInt:_informationModel.sentiment];
    if (isInt) {
        sentimentStr = [NSString stringWithFormat:@"%@.0",_informationModel.sentiment];
    }
    else{
        float change = [_informationModel.sentiment floatValue];
        sentimentStr = [NSString stringWithFormat:@"%0.3f",change];
    }
    _sentimentLab.text = sentimentStr;
    _sentimentLab.frame = _informationFrameModel.sentimentF;
    
    _titleLab.text =_informationModel.title;
    _titleLab.frame = _informationFrameModel.titleF;
    
//    _urlLab.text =_informationModel.url;
    _urlLab.frame = _informationFrameModel.urlF;
    NSUInteger length = [_informationModel.url length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_informationModel.url];
    [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, length)];
    [_urlLab setAttributedText:attri];
    
    
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

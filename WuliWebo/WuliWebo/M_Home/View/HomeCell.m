//
//  HomeCell.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/4.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "HomeCell.h"
#import <UIImageView+WebCache.h>

@interface HomeCell ()

/**
 *  底图
 */
@property (strong, nonatomic) UIView *baseView;

/**
 *  发布人的头像
 */
@property (strong, nonatomic) UIImageView *userImageView;

/**
 *  发布人的名字
 */
@property (strong, nonatomic) UILabel *userNameLabel;

/**
 *  内容
 */
@property (strong, nonatomic) UILabel *contentLabel;

/**
 *  分割线
 */
@property (strong, nonatomic) UIView *lineView;

/**
 *  转发内容
 */
@property (strong, nonatomic) UILabel *retweetedLabel;

@end

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        [self UICommonset];
    }
    return self;
}

/**
 *  界面设计
 */
-(void)UICommonset{
    
    [self.contentView setBackgroundColor:HOME_BG_COLOR];

    //底图
    [self.contentView addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).with.offset(4);
        make.right.equalTo(self.contentView.mas_right).with.offset(-4);
        make.top.equalTo(self.contentView.mas_top).with.offset(4);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-4);

    }];
    
    //头像
    [self.contentView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).with.offset(14);
        make.top.equalTo(self.contentView.mas_top).with.offset(14);
//        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    //名字
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.userImageView.mas_right).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-14);
        make.top.equalTo(self.userImageView.mas_top).with.offset(5);

        make.height.mas_equalTo(20);
    }];
    
    //内容
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.userImageView.mas_bottom).with.offset(5);
//        make.bottom.equalTo(self.lineView.mas_top).with.offset(-5);
//        make.height.mas_equalTo(10);

    }];

    //线
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(5);
        
        make.height.mas_equalTo(1);

    }];

    //转发内容
    [self.contentView addSubview:self.retweetedLabel];
    [self.retweetedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);

//        make.height.mas_equalTo(0);
        
    }];

}

-(void)setModel:(HomeModel *)model{
    
    _model = model;
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.userImageName] placeholderImage:[UIImage imageNamed:@"placholder"]];
    self.userNameLabel.text = model.username;
    
    self.contentLabel.text = model.content;
    
    //处理内容下边距根据转发内容有没有改变
    if (model.retweetedText.length > 0) {
        
        [self.retweetedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);

        }];
    }else{
        [self.retweetedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            
        }];
    }
    
    [self.lineView setHidden:(model.retweetedText.length>0?NO:YES)];
    self.retweetedLabel.text = model.retweetedText;
}

#pragma mark - getter and setter

/**
 *  底图
 *
 *  @return 底图
 */
-(UIView *)baseView{
    
    if (!_baseView) {
        
        _baseView = [[UIView alloc]init];
        [_baseView setBackgroundColor:WHITE_COLOR];
        _baseView.opaque = YES;
    }
    
    return _baseView;
}

/**
 *  用户头像
 *
 *  @return 头像
 */
-(UIImageView *)userImageView{
    
    if (!_userImageView) {
        
        _userImageView = [[UIImageView alloc]init];
    }
    
    return _userImageView;
}

/**
 *  姓名
 *
 *  @return 姓名
 */
-(UILabel *)userNameLabel{
    
    if (!_userNameLabel) {
        
        _userNameLabel = [[UILabel alloc]init];
        
    }
    
    return _userNameLabel;
}

/**
 *  内容
 *
 *  @return 内容
 */
-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    return _contentLabel;
}

/**
 *  线
 *
 *  @return 线
 */
-(UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:[UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.00]];
        
    }
    
    return _lineView;
}

-(UILabel *)retweetedLabel{
    
    if (!_retweetedLabel) {
        
        _retweetedLabel = [[UILabel alloc]init];
        [_retweetedLabel setNumberOfLines:0];
        [_retweetedLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    return _retweetedLabel;

}

@end

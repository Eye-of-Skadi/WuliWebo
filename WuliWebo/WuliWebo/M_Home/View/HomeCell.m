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
    [self.baseView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.baseView.mas_left).with.offset(10);
        make.top.equalTo(self.baseView.mas_top).with.offset(10);
        
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    //名字
    [self.baseView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.userImageView.mas_right).with.offset(10);
        make.right.equalTo(self.baseView.mas_right).with.offset(-10);
        make.top.equalTo(self.userImageView.mas_top).with.offset(5);

        make.height.mas_equalTo(20);
    }];
    
    //内容
    [self.baseView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView.mas_left).with.offset(10);
        make.right.equalTo(self.baseView.mas_right).with.offset(-10);
        make.top.equalTo(self.userImageView.mas_bottom).with.offset(5);
        
        make.height.mas_equalTo(30);

    }];
}

/**
 *  重设界面
 *
 *  @param dic 数据
 */
-(void)resetUIWithobj:(NSDictionary*)dic{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id userObj = [dic verifiedObjectForKey:@"user"];
        if ([userObj isKindOfClass:[NSDictionary class]]) {
            //设置用户信息
            [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[userObj verifiedObjectForKey:@"profile_image_url"]] placeholderImage:nil];
            [self.userNameLabel setText:[userObj verifiedObjectForKey:@"name"]];
        }
        
        //内容
        [self.contentLabel setText:[dic verifiedObjectForKey:@"text"]];

    });
    
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

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        
    }
    
    return _contentLabel;
}

@end

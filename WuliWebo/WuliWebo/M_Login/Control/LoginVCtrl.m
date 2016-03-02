//
//  LoginVCtrl.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/26.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "LoginVCtrl.h"
#import "LoginModel.h"
#import "LoginView.h"


@interface LoginVCtrl ()

/**
 *  登录按钮
 */
@property (strong, nonatomic) UIButton *loginBtn;

/**
 *  背景图片
 */
@property (strong, nonatomic) UIImageView *bgImageView;

@end

@implementation LoginVCtrl

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    /**
     *  组件的布局
     */
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:WHITE_COLOR];

    //背景图片
    [self.view addSubview:self.bgImageView];
    
    //添加登录按钮
    [self.view addSubview:self.loginBtn];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.loginBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSString *token = [[NSUserDefaults standardUserDefaults]stringForKey:@"Token"];
        if (token == nil) {
            [LoginModel login];
        }else{
            //            [self skipToMainViewCtrl];
        }
        
        return [RACSignal empty];
    }];

}

#pragma mark - getter And setter

-(UIButton *)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [LoginView createLoginBtn];
    }
    
    return _loginBtn;
}

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        _bgImageView = [LoginView createBGImageView];
    }
    
    return _bgImageView;
}

@end

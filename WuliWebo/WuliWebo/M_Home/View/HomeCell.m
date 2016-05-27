//
//  HomeCell.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/4.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "HomeCell.h"
#import <UIImageView+WebCache.h>
#import "ASHorizontalScrollView.h"
#import <MWPhotoBrowser.h>

#define RGB(r, g, b)     [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]

@interface HomeCell ()<MWPhotoBrowserDelegate>

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

/**
 *  图片
 */
@property (strong, nonatomic) ASHorizontalScrollView *horizontalScrollView;
/**
 *   图片们
 */
@property (nonatomic) NSMutableArray* images;
@property (nonatomic) NSMutableArray *photos;
@end

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.images = [[NSMutableArray alloc]init];
        self.photos = [[NSMutableArray alloc]init];

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
        
        make.height.mas_equalTo(0);
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
        make.height.mas_equalTo(0);

    }];


    //图片
    [self.contentView addSubview:self.horizontalScrollView];
    [self.horizontalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.retweetedLabel.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.mas_equalTo(120);
    }];
}

-(void)UIResetWithModel:(HomeModel *)model{
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.userImageName] placeholderImage:[UIImage imageNamed:@"placholder"]];
    self.userNameLabel.text = model.username;
    
    //内容
    self.contentLabel.text = model.content;
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.userImageView.mas_bottom).with.offset(5);
        
        make.height.mas_greaterThanOrEqualTo([PublicMethods heightWithString:self.contentLabel.text andWidth:[UIScreen mainScreen].bounds.size.width-20 andTextFont:self.contentLabel.font]);
    }];
    
    //转发内容
    self.retweetedLabel.text = model.retweetedText;
    if ([model.retweetedText isEqualToString:@""]) {
        [self.retweetedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(-5);
            make.height.mas_equalTo(0);
        }];

    }else{
        [self.retweetedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
            make.height.mas_greaterThanOrEqualTo([PublicMethods heightWithString:self.retweetedLabel.text andWidth:[UIScreen mainScreen].bounds.size.width-20 andTextFont:self.retweetedLabel.font]);
        }];

    }

    //图片
    [self.horizontalScrollView removeAllItems];
    [self.photos removeAllObjects];
    
    id picObj = model.pic_urls;
    
    if ([picObj isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *imageViews = [NSMutableArray array];

        self.images = [[NSMutableArray alloc]initWithArray:picObj];
        for (NSDictionary *imageDic in self.images) {
            
            [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[imageDic verifiedObjectForKey:@"thumbnail_pic"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"]]]];
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[imageDic verifiedObjectForKey:@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"placholder"]];
            [imageViews addObject:imageView];
            
            [imageView setTag:[self.images indexOfObject:imageDic]];
            
            [imageView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleImageSelect:)];
            [imageView addGestureRecognizer:tap];
        }
        [self.horizontalScrollView addItems:imageViews];
        
        
        if (self.images.count < 1) {
            
            [_horizontalScrollView setHidden:YES];

        }else{
            
            [_horizontalScrollView setHidden:NO];
        }
    }
    [self.lineView setHidden:(model.retweetedText.length>0?NO:YES)];
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

-(ASHorizontalScrollView *)horizontalScrollView{
    
    if (!_horizontalScrollView) {
        _horizontalScrollView = [[ASHorizontalScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
        _horizontalScrollView.uniformItemSize = CGSizeMake(120, 120);
    }
    return _horizontalScrollView;
}

- (void)handleImageSelect:(UITapGestureRecognizer*)tap{
    
    UIImageView *imageView = (UIImageView*)[tap view];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Present
    [[self viewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:browser] animated:YES completion:nil];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:imageView.tag];
}

- (UIViewController *)viewController{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
@end

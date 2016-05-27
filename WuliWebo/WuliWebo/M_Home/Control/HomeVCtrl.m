//
//  HomeVCtrl].m
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/2.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "HomeVCtrl.h"
#import "HomeView.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import <MJRefresh.h>
#import "UITableView+FDTemplateLayoutCell.h"

#define HOME_URL @"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@&count=20"

@interface HomeVCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *sourceAry;
@property (nonatomic, copy) NSArray *prototypeEntitiesFromJSON;

@end

@implementation HomeVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:WHITE_COLOR];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]stringForKey:@"Token"];
    NSString *homeUrl = [NSString stringWithFormat:HOME_URL,token];

    [PublicMethods connectWebserviceWithUrlstr:homeUrl andParameter:nil andSuccessBlock:^(id responsObject) {
        
        if ([responsObject isKindOfClass:[NSDictionary class]]) {
            
            id obj = [responsObject verifiedObjectForKey:@"statuses"];
            if ([obj isKindOfClass:[NSArray class]]) {
                
                [self buildTestDataWithAry:obj Then:^{
                    [self.sourceAry addObjectsFromArray:self.prototypeEntitiesFromJSON];
                    [self.tableView reloadData];
                }];
            }
            
        }
        
        
    } andFaildBlock:^(NSString *errorDes) {
        
        NSLog(@"%@",errorDes);
        
    }];
}

- (void)buildTestDataWithAry:(NSArray*)ary Then:(void (^)(void))then {
    
    NSMutableArray *entities = @[].mutableCopy;
    
    [ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        id userObj = [obj verifiedObjectForKey:@"user"];
        
        if ([userObj isKindOfClass:[NSDictionary class]]) {
            //设置用户信息
            [dic setObject:[userObj verifiedObjectForKey:@"name"] forKey:@"username"];
            [dic setObject:[userObj verifiedObjectForKey:@"profile_image_url"] forKey:@"userImageName"];
        }
        
        [dic setObject:[obj verifiedObjectForKey:@"text"] forKey:@"content"];
        
        //判断有没有转发内容
        id retweeted_statusObj = [obj verifiedObjectForKey:@"retweeted_status"];
        if ([retweeted_statusObj isKindOfClass:[NSDictionary class]]) {
            
            //被转发用户
            id retweetedUserObj = [retweeted_statusObj verifiedObjectForKey:@"user"];
            
            if ([retweetedUserObj isKindOfClass:[NSDictionary class]]) {
                
                NSString *retweetedText = [NSString stringWithFormat:@"%@:%@",[retweetedUserObj verifiedObjectForKey:@"name"],[retweeted_statusObj verifiedObjectForKey:@"text"]];
                
                [dic setObject:retweetedText forKey:@"retweetedText"];
                
            }
            
            id picObj = [retweeted_statusObj verifiedObjectForKey:@"pic_urls"];
            if ([picObj isKindOfClass:[NSArray class]]) {
                [dic setObject:picObj forKey:@"pic_urls"];
            }else{
                
                [dic setObject:@[].mutableCopy forKey:@"pic_urls"];
            }

            [dic setObject:picObj forKey:@"pic_urls"];
        }else{
            
            id picObj = [obj verifiedObjectForKey:@"pic_urls"];
            if ([picObj isKindOfClass:[NSArray class]]) {
                [dic setObject:picObj forKey:@"pic_urls"];
            }else{
                
                [dic setObject:@[].mutableCopy forKey:@"pic_urls"];
            }
        }
        
        [entities addObject:[[HomeModel alloc] initWithDictionary:dic]];
    }];
    self.prototypeEntitiesFromJSON = entities;
    
    // Callback
    dispatch_async(dispatch_get_main_queue(), ^{
        !then ?: then();
    });
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableView setBackgroundColor:HOME_BG_COLOR];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"HomeCell";
    HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!homeCell) {
        homeCell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }

    [self configureCell:homeCell atIndexPath:indexPath];
    
    return homeCell;
}

- (void)configureCell:(HomeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = [self.sourceAry objectAtIndex:indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"HomeCell" cacheByIndexPath:indexPath configuration:^(HomeCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter And setter

-(NSMutableArray *)sourceAry{
    
    if (!_sourceAry) {
        _sourceAry = [[NSMutableArray alloc]init];
    }
    
    return _sourceAry;
}
@end

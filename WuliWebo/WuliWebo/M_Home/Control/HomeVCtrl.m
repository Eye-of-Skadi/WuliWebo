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

#define HOME_URL @"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@&count=20"

@interface HomeVCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *sourceAry;

@end

@implementation HomeVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:WHITE_COLOR];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]stringForKey:@"Token"];
    NSString *homeUrl = [NSString stringWithFormat:HOME_URL,token];

    [PublicMethods connectWebserviceWithUrlstr:homeUrl andParameter:nil andSuccessBlock:^(id responsObject) {
        
        NSLog(@"%@",responsObject);
        if ([responsObject isKindOfClass:[NSDictionary class]]) {
            
            id obj = [responsObject verifiedObjectForKey:@"statuses"];
            if ([obj isKindOfClass:[NSArray class]]) {
                
                [self.sourceAry addObjectsFromArray:obj];
                [self.tableView reloadData];
            }
            
        }
        
        
    } andFaildBlock:^(NSString *errorDes) {
        
        NSLog(@"%@",errorDes);
        
    }];
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
    
    [homeCell resetUIWithobj:[self.sourceAry objectAtIndex:indexPath.row]];
    
    return homeCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
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

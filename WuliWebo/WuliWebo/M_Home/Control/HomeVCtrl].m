//
//  HomeVCtrl].m
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/2.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "HomeVCtrl].h"

#define HOME_URL @"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@&count=20"

@interface HomeVCtrl_ ()

@end

@implementation HomeVCtrl_

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:WHITE_COLOR];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]stringForKey:@"Token"];
    NSString *homeUrl = [NSString stringWithFormat:HOME_URL,token];

    [PublicMethods connectWebserviceWithUrlstr:homeUrl andParameter:nil andSuccessBlock:^(id responsObject) {
        
        NSLog(@"%@",responsObject);
        
    } andFaildBlock:^(NSString *errorDes) {
        NSLog(@"%@",errorDes);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

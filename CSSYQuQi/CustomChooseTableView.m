//
//  CustomChooseTableView.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/23.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CustomChooseTableView.h"
#import "CustomChooseTableViewCell.h"

@implementation CustomChooseTableView {
    BOOL _isFirst;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        _isFirst = YES;
        [self initall];
    }
    return self;
}

- (void)initall {
    [self initArray];
    [self createDownMenu];
    [self createTableView];
}
- (void)initArray {
    self.prices = @[@"价格",@"0-5万",@"5-8万",@"8-10万",@"10-15万",@"15-20万",@"20-25万",@"25-35万",@"35-50万",@"50-70万",@"70-100万",@"100-150万",@"150万以上"];
    self.carType = @[@"车型",@"轿车",@"跑车",@"suv",@"mpv",@"面包车",@"皮卡",@"客货车"];
    self.countrys = @[@"国家",@"中国",@"德国",@"意大利",@"捷克",@"日本",@"法国",@"澳大利亚",@"瑞典",@"美国",@"英国",@"荷兰",@"法国"];
    self.originalArray = @[[NSString stringWithFormat:@"%@_%@_%@",self.prices[1],self.carType[1],self.countrys[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[1],self.carType[1],self.countrys[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[1],self.carType[2],self.countrys[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[1],self.carType[2],self.countrys[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[2],self.carType[1],self.countrys[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[2],self.carType[1],self.countrys[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[2],self.carType[2],self.countrys[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.prices[2],self.carType[2],self.countrys[2]]];
    self.results = self.originalArray;
}
//创建选择器
- (void)createDownMenu {
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:30];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self addSubview:menu];
}
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    switch (column) {
        case 0: return self.prices.count;
            break;
        case 1: return self.carType.count;
            break;
        case 2: return self.countrys.count;
            break;
        default:
            return 0;
            break;
            
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    
        switch (indexPath.column) {
            case 0: return self.prices[indexPath.row];
                break;
            case 1: return self.carType[indexPath.row];
                break;
            case 2: return self.countrys[indexPath.row];
                break;
            default:
                return nil;
                break;
                
        }

    
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
        ZEBLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
        ZEBLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
        NSString *title = [menu titleForRowAtIndexPath:indexPath];
        
        static NSString *prediStr1 = @"SELF LIKE '*'",
        *prediStr2 = @"SELF LIKE '*'",
        *prediStr3 = @"SELF LIKE '*'";
        switch (indexPath.column) {
            case 0:{
                if (indexPath.row == 0) {
                    prediStr1 = @"SELF LIKE '*'";
                } else {
                    prediStr1 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
                }
            }
                break;
            case 1:{
                if (indexPath.row == 0) {
                    prediStr2 = @"SELF LIKE '*'";
                } else {
                    prediStr2 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
                }
            }
                break;
            case 2:{
                if (indexPath.row == 0) {
                    prediStr3 = @"SELF LIKE '*'";
                } else {
                    prediStr3 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
                }
            }
                
            default:
                break;
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ AND %@ AND %@",prediStr1,prediStr2,prediStr3]];
        
        self.results = [self.originalArray filteredArrayUsingPredicate:predicate];
        [self.tableView reloadData];
}
- (void)createTableView {
    self.tableView = ({
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, screenSize.width, screenSize.height - 104) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        tableView;
    });
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self prepareLoadData:NO];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self prepareLoadData:YES];
    }];
    _tableView.header = header;
    _tableView.footer = footer;
    [_tableView.header beginRefreshing];
    
}
//准备加载数据
- (void)prepareLoadData:(BOOL)isMore {
    NSString *url = @"";
    
    NSInteger page = 1;
    if (isMore) {
        page = page+1;
    }
    [self loadingData:url isMore:isMore];
}
//开始加载数据
- (void)loadingData:(NSString *)url isMore:(BOOL)isMore {
    [MBProgressHUD showMessage:@"努力加载中..." toView:self dimBackground:NO];
    if (!isMore) {
        [_tableView.header endRefreshing];
    }else {
        [_tableView.footer endRefreshing];
    }
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    CustomChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[CustomChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   
    cell.name = self.results[indexPath.row];
    return cell;
}
//代理跳转界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_cusChooseSkipDetailDelegate && [_cusChooseSkipDetailDelegate respondsToSelector:@selector(customChooseSkipDetail:)]) {
        [_cusChooseSkipDetailDelegate customChooseSkipDetail:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  M8SettingViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/13.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8SettingViewController.h"
#import "M8AdminViewController.h"
#import "ProductNetworkViewController.h"
#import "DownloadViewController.h"
#import "settingViewCell.h"
#import "SettingFootView.h"
#import "NSString+Wrapper.h"
//#import "HYXMLParser.h"
//#import "MJExtension.h"
//#import "XmlArrayOfStringModel.h"
//#import "XMLReader.h"
//#import "XMLWriter.h"
//#import "JSONKit.h"

@interface M8SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingFootViewDelegate,NSXMLParserDelegate>
@property(nonatomic,strong) NSArray *oneSettings;
@property(nonatomic,strong) NSArray *twoSettings;

//添加属性
@property (nonatomic, strong) NSXMLParser *par;
//存放每个解析出来的数据
@property (nonatomic, strong) NSMutableArray *list;
//标记当前标签，以索引找到XML文件内容
//@property (nonatomic, copy) NSString *currentElement;
////解析的单个元素
//@property (nonatomic, copy) NSString *currentValue;
//声明parse方法，通过它实现解析
-(void)parse;
@end

@implementation M8SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self initWithNavBar];
    [self initWithData];
    [self initWithTableView];
}

-(void)initWithNavBar{
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:24]};
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithData{
    _oneSettings = [NSArray arrayWithObjects:@"产品网络关系",@"资料下载",@"注册到机构", nil];
    _twoSettings = [NSArray arrayWithObjects:@"备份",@"还原", nil];
    
}

-(void)initWithTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[settingViewCell class] forCellReuseIdentifier:@"setCell"];
    CGFloat foot_h = 90;
    SettingFootView *footerView = [[SettingFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, foot_h)];
    footerView.delegate = self;
    [tableView setTableFooterView:footerView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"setCell";
    settingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[settingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.titleLb.text = [_oneSettings objectAtIndex:indexPath.row];
    }else{
        cell.titleLb.text = [_twoSettings objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ProductNetworkViewController *pnvc = [[ProductNetworkViewController alloc] init];
            pnvc.title = [_oneSettings objectAtIndex:indexPath.row];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:pnvc animated:YES];
            [self setHidesBottomBarWhenPushed:YES];
        }else if (indexPath.row == 1){
            DownloadViewController *dvc = [[DownloadViewController alloc] init];
            dvc.title = [_oneSettings objectAtIndex:indexPath.row];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:dvc animated:YES];
            [self setHidesBottomBarWhenPushed:YES];
        }else{
            //注册到机构
            [self registerToAgency];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [settingViewCell getCellHeight];
}

-(void)registerToAgency{
    NSString *password = [[LYUserDefault loadUserPasswardCache] md532BitUpper];
    NSLog(@"password:%@",password);
    NSString *RegistrationCode = @"PJ2R894X";
    NSDictionary *parameters = @{@"Passowrd":password,@"InviteCode":RegistrationCode};
    [self startMBProgressHUDWithText:@"正在注册到机构..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *regUrl = [NSString stringWithFormat:@"%@",URL_REGISTER_AGENCY];
    [manager POST:regUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self stopMBProgressHUD];
        if (responseObject != nil) {
            NSString *registerReturn = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"registerReturn: %@", registerReturn);
            NSData *dataRegReturn = [registerReturn dataUsingEncoding:NSUTF8StringEncoding];
            [self XMLParserWithData:dataRegReturn];
            if (self.list.count>0) {
                if ([self.list[0] isEqualToString:@"OK"] && _list.count >= 4) {
                    //注册成功
                    [self saveAdminMessageWith:_list];  
                }else if([self.list[0] isEqualToString:@"Error"] && _list.count >= 2){ //邀请码已被使用
                    [self showAlertViewWithText:_list[1]];
                }
            }
//            //初始化数组，存放解析后的数据
//            self.list = [NSMutableArray arrayWithCapacity:5];
//            self.par = [[NSXMLParser alloc] initWithData:responseObject];
//            //添加代理
//            self.par.delegate = self;
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self stopMBProgressHUD];
        NSLog(@"Error: %@", error);
        
    }];
}

#pragma mark - buttonAction
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SettingFootViewDelegate
-(void)loginOutButtonClick{
    [self dismissViewControllerAnimated:nil completion:nil];
}

#pragma mark - 进度条
//启动进度条
-(void)startMBProgressHUDWithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
}
//关闭进度条
-(void)stopMBProgressHUD{
    [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
}
//*利用 NSXMLParser 方式
-(void)XMLParserWithData:(NSData *)data{
    //1.创建NSXMLParser
    NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
    //2.设置代理
    [XMLParser setDelegate:self];
    //3.开始解析
    [XMLParser parse];
}
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"开始解析...");
    self.list = [NSMutableArray arrayWithCapacity:4];
}

//准备节点
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{

//}

//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //    NSLog(@"string:%@" , string);
    if ([string isEqualToString:@""]) {
        return;
    }
    [self.list addObject:string];
}

////解析完一个节点
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{

//}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
//    NSLog(@"XML所有元素解析完毕:%@",self.list);
//    if (_list.count>0) {
//        NSLog(@"list[0]:%@",_list[0]);
//        NSLog(@"list[1]:%@",_list[1]);
//    }
}

//注册成功，保存管理员信息
-(void)saveAdminMessageWith:(NSArray *)array{
    //缓存用户名
    [LYUserDefault saveUserNameCache:_list[1]];
    //缓存用户名所属机构类型
    [LYUserDefault saveDeptTypeCache:_list[2]];
    //缓存用户名所属机构名称
    [LYUserDefault saveDeptNameCache:_list[3]];
}

//弹出提示框
-(void)showAlertViewWithText:(NSString *)txt{
    UIAlertController *alertView =
    [UIAlertController alertControllerWithTitle:@"提示"
                                        message:txt
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alertView addAction:action];
    [self presentViewController:alertView animated:YES completion:nil];
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

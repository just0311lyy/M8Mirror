//
//  MOCameraViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "MOCameraViewController.h"
#import "CameraTypeButtonView.h"
#import "MOPhotoShowViewController.h"
#import "PhotoView.h"
#import <AudioToolbox/AudioToolbox.h> //声音

//#include <ifaddrs.h>
//#include <arpa/inet.h>
//#include <net/if.h>
#import "MLUtils.h"
#import "MLCameraLibs.h"

#import "ReportModel.h"
#import "NSString+Wrapper.h"
@interface MOCameraViewController ()<CameraTypeButtonViewDelegate>
@property (strong, nonatomic) UIImageView *playerImgView;
@property (strong, nonatomic) UIButton *takePhotoBtn;
@property (strong, nonatomic) CameraTypeButtonView *typeBtnView; //拍照类型
@property (strong, nonatomic) UIImageView *photoImgView; //展示拍完的照片
@property (strong, nonatomic) NSString *RGBPhotoString;  //拍的RGB照片路径
@property (strong, nonatomic) NSString *UVPhotoString;
@property (strong, nonatomic) NSString *PZPhotoString;

@property (assign, nonatomic) NSInteger video_width;
@property (assign, nonatomic) NSInteger video_height;

//@property (strong, nonatomic) ReportModel *photoModel;
@end

@implementation MOCameraViewController
{
    void *mCamera;
}

bool isDisplaying       = false;
bool isNeedSnapPhoto    = false;
bool isRecording        = false;
bool keyThreadRunning   = false;
//是否已经有了拍照图片
bool isRGBPhoto  = false;
bool isUVPhoto   = false;
bool isPZPhoto   = false;

- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序程序.
    [self startPreview]; //拍照运行
    //设置屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    [self stopPreview];
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
//    [self initWithData];
    [self initWithView];
}

-(void)initWithNavBar{
    self.title = @"新检测";
//    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x151515);
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithView{
    _playerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H)];
    _playerImgView.backgroundColor = UIColorFromRGB(0x151515);
    [self.view addSubview:_playerImgView];
    
    NSInteger btnNumber = 3;
    CGFloat typeBtn_h = btnNumber * 100;
    _typeBtnView = [[CameraTypeButtonView alloc] initWithFrame:CGRectMake(30, (SCREEN_H-typeBtn_h)/2, 80,typeBtn_h) andNumber:btnNumber];
    _typeBtnView.delegate = self;
    _typeBtnView.RGBGBtn.selected = YES;
    [_typeBtnView.RGBGBtn setTintColor:UIColorFromRGB(0x00f8ff)];
    [self.view addSubview:_typeBtnView];
    
    CGFloat btn_w = 80;
    CGFloat space = 20;
    _takePhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_W - btn_w)/2,CGRectGetHeight(_playerImgView.frame) - btn_w - space,btn_w,btn_w)];
    [_takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"takephoto.png"] forState:UIControlStateNormal];
//    [_takePhotoBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    _takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:22];
//    [_takePhotoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_takePhotoBtn setBackgroundColor:[UIColor whiteColor]];
    [_takePhotoBtn addTarget:self action:@selector(takePhotoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_takePhotoBtn];
    
    //(640,480)
    CGFloat imgView_w = 48*2;
    CGFloat imgView_h = 64*2;
    _photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_W - imgView_w)/2,SCREEN_H - (btn_w + space) - imgView_h - space, imgView_w, imgView_h)];
    _photoImgView.layer.borderWidth = 1;
    _photoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_photoImgView];
//    CGFloat photoView_W = (48*2) * 2 + 20;
//    CGFloat photoView_H = 64*2;
//    _RGBphotoView = [[PhotoView alloc] initWithFrame:CGRectMake((SCREEN_W - photoView_W)/2, SCREEN_H - 100 - photoView_H - 20, photoView_W, photoView_H)];
//    [self.view addSubview:_RGBphotoView];
//
//    _UVphotoView = [[PhotoView alloc] initWithFrame:CGRectMake((SCREEN_W - photoView_W)/2, SCREEN_H - 100 - photoView_H - 20, photoView_W, photoView_H)];
//    _UVphotoView.hidden = YES;
//    [self.view addSubview:_UVphotoView];
//
//    _PZphotoView = [[PhotoView alloc] initWithFrame:CGRectMake((SCREEN_W - photoView_W)/2, SCREEN_H - 100 - photoView_H - 20, photoView_W, photoView_H)];
//    _PZphotoView.hidden = YES;
//    [self.view addSubview:_PZphotoView];
    
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - btn_w,CGRectGetMinY(_takePhotoBtn.frame) + space/2,btn_w - space,btn_w-space)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"round_selected.png"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(pushNextView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

- (void)startPreview {
    if(isDisplaying) {
        NSLog(@"the camera is previewing(预映) now, do not need start again.");
        return;
    }
    if(nullptr == mCamera) {
        //这里的IP可以在局域网搜索后自行替换
        NSString *strIp = @"192.168.10.123";
        mCamera = [MLCameraLibs ML_StartPreview:strIp];
    }
    //异步读取显示
    [NSThread detachNewThreadSelector:@selector(readImage) toTarget:self withObject:nil];
    //获取按键状态 或 串口透传
    [NSThread detachNewThreadSelector:@selector(doGetRemoteKeyThread) toTarget:self withObject:nil];
    NSLog(@"start preview");
}

- (void)readImage {
    isDisplaying = true;
    int frameSize = 0;
    int video_format = 0;
    int video_width, video_height = 0;
    char *buffer = (char *)malloc(200*1000);
    while(isDisplaying) {
        /* autoreleasepool to release the NSData:imageData */
        @autoreleasepool {
            if(mCamera != nullptr) {
                [MLCameraLibs ML_GetVideoParams:mCamera format:&video_format width:&video_width height:&video_height];
                if(video_format <= 0) {
                    usleep(100*1000);
                    continue;
                }
                if(_video_width != video_width || _video_height != video_height) {
                    _video_height = video_height;
                    _video_width = video_width;
                }
                frameSize = [MLCameraLibs ML_GetVideoFrame:mCamera gotBuf:buffer];
                if(frameSize > 0) {
                    NSData *imageData = [NSData dataWithBytes:buffer length:frameSize];
                    UIImage *image = [UIImage imageWithData:imageData];
                    if(isRecording)
                        [MLUtils addAVIRecData:imageData andSize:[imageData length]];
                    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
                }else {
                    usleep(10*1000);
                }
            }else {
                usleep(1000*1000);
            }
        }
    }
    NSLog(@"stop display image now...");
}

- (void) displayImage:(UIImage *)image {
    _playerImgView.image = image;
    
    //这里是将图片保存到本地
    if(isNeedSnapPhoto) {
//        NSString *imagePath = [MLUtils getPhotosPath];
//        NSLog(@"Image path:%@", imagePath);
//        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
//        [UIImageJPEGRepresentation(image, 0.8) writeToFile:imagePath atomically:YES];
//        UIImage *takedImage = [UIImage imageWithContentsOfFile:imagePath];
        if (_typeBtnView.RGBGBtn.selected) {
            if ([_RGBPhotoString isEqualToString:@""]) {
                _RGBPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _RGBPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_RGBPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_RGBPhotoString];
            }else{
                //先删除已保存的路径
                [MLUtils deleteFile:_RGBPhotoString];
                //再保存新的拍照路径
                _RGBPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _RGBPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_RGBPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_RGBPhotoString];
            }
        }else if (_typeBtnView.UVGBtn.selected){
            if ([_UVPhotoString isEqualToString:@""]) {
                _UVPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _UVPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_UVPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_UVPhotoString];
            }else{
                //先删除已保存的路径
                [MLUtils deleteFile:_UVPhotoString];
                //再保存新的拍照路径
                _UVPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _UVPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_UVPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_UVPhotoString];
            }
        }else if (_typeBtnView.PZGBtn.selected){
            if ([_PZPhotoString isEqualToString:@""]) {
                _PZPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _PZPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_PZPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_PZPhotoString];
            }else{
                //先删除已保存的路径
                [MLUtils deleteFile:_PZPhotoString];
                //再保存新的拍照路径
                _PZPhotoString = [MLUtils getPhotosPath];
                NSLog(@"RGBImage path:%@", _PZPhotoString);
                [UIImageJPEGRepresentation(image, 0.8) writeToFile:_PZPhotoString atomically:YES];
                _photoImgView.image = [UIImage imageWithContentsOfFile:_PZPhotoString];
            }
        }
        
        
        
//        if (!_RGBphotoView.hidden) {
//
//        }else if (!_UVphotoView.hidden){
//
//        }else{
//            [_RGBphotoView.leftPhotoBtn setBackgroundImage:takedImage forState:UIControlStateNormal];
//        }
        //保存图片到系统相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        isNeedSnapPhoto = false;
    }
}

/**
 获取模块端的按键状态线程
 */
- (void)doGetRemoteKeyThread {
    keyThreadRunning = true;
    int val, type = 0;
    int ret = 0;
    //这里的IP可以在局域网搜索后自行替换
    void *pCmd = [MLUtils ML_InitCmdSocket:@"192.168.10.123"];
    while (keyThreadRunning) {
        type = [MLUtils ML_SendGetKeyOrUart:pCmd];
        if(type <= 0) {
            usleep(200*1000);
            continue;
        }
        if(type == 1) {
            NSLog(@"Device support [KEY]");
            while (keyThreadRunning) {
                val = [MLUtils ML_SendGetKeyStatus:pCmd];
                if(val == 1) {
                    //do snap
                }else if(val == 2) {
                    //do record
                }
                usleep(200*1000);
            }
        }else if(type == 2) {
            NSLog(@"Device support [UART]");
            void *pUart = [MLUtils ML_InitUartSocket:@"192.168.10.123"];
            if(pUart) {
                while (keyThreadRunning) {
                    uint8_t data[100] = {'a', 'b', 'c', 'd', 'e', 'f'};
                    [MLUtils ML_UartSendData:pUart andData:data len:6];
                    ret = [MLUtils ML_UartRecvData:pUart andData:data];
                    if(ret > 0)
                        NSLog(@"Receive data %i: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x", ret, data[0], data[1], data[2], data[3], data[4]);
                    usleep(100*1000);
                }
            }
        }
        usleep(100*1000);
    }
    [MLUtils ML_DeinitCmdSocket:pCmd];
}


- (void)stopPreview{
    keyThreadRunning = false;
    if(mCamera != nullptr) {
        [MLCameraLibs ML_StopPreview:mCamera];
        mCamera = nullptr;
    }
    isDisplaying = false;
//    [self stopRecord];
    NSLog(@"stoppreview and record");
}

#pragma mark - buttonAction
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)takePhotoBtnAction{
    isNeedSnapPhoto = true;
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"photoShutter" ofType:@"caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)pushNextView{
    //判断是否每个照片类型均拍完照片
//    if (![_RGBPhotoString isEqualToString:@""] && ![_UVPhotoString isEqualToString:@""] && ![_PZPhotoString isEqualToString:@""]) {
//
//    }
    if ([_RGBPhotoString isEqualToString:@""] || _RGBPhotoString == nil) {
        [self showAlertViewWithText:@"RGB光拍照不能为空"];
    }else if ([_UVPhotoString isEqualToString:@""] || _UVPhotoString == nil){
        [self showAlertViewWithText:@"UV光拍照不能为空"];
    }else if ([_PZPhotoString isEqualToString:@""] || _PZPhotoString == nil){
        [self showAlertViewWithText:@"偏振光拍照不能为空"];
    }else{
        ReportModel *model = [[ReportModel alloc] init];
        model.customerId = _currentCust.customerId;
        model.oneImgPathStr = _RGBPhotoString;
        model.twoImgPathStr = _UVPhotoString;
        model.threeImgPathStr = _PZPhotoString;
        model.fourImgPathStr = model.fiveImgPathStr = model.sixImgPathStr = model.sevenImgPathStr = model.eightImgPathStr = model.nineImgPathStr = _PZPhotoString;

        //创建时间
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
        [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
        NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
        model.reportDate = dateString;
        //推出拍照完成的界面
        MOPhotoShowViewController *showVC = [[MOPhotoShowViewController alloc] init];
        showVC.title = @"拍照完成";
        showVC.currentShowReport = model;
        showVC.currentShowCust = _currentCust;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:showVC animated:YES];
        [self setHidesBottomBarWhenPushed:YES];
    }
//    MOPhotoShowViewController *showVC = [[MOPhotoShowViewController alloc] init];
//    showVC.title = @"新检测";
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:showVC animated:YES];
//    [self setHidesBottomBarWhenPushed:YES];
}

#pragma mark - CameraTypeButtonViewDelegate
-(void)cameraTypeButtonClickWithTag:(NSInteger)btnTag{
    switch (btnTag) {
        case TAG_UVG:
            if ([_UVPhotoString isEqualToString:@""]) {
                _photoImgView.image = [UIImage imageNamed:@""];
            }else{
                _photoImgView.image = [UIImage imageWithContentsOfFile:_UVPhotoString];
            }
            break;
        case TAG_PZG:
            if ([_PZPhotoString isEqualToString:@""]) {
                _photoImgView.image = [UIImage imageNamed:@""];
            }else{
                _photoImgView.image = [UIImage imageWithContentsOfFile:_PZPhotoString];
            }
            break;
        default:
            if ([_RGBPhotoString isEqualToString:@""]) {
                _photoImgView.image = [UIImage imageNamed:@""];
            }else{
                _photoImgView.image = [UIImage imageWithContentsOfFile:_RGBPhotoString];
            }
            break;
    }
}

#pragma mark - 通知监听程序是否进入后台
- (void)applicationWillResignActive:(NSNotification *)notification {
    [self stopPreview];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self startPreview];
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

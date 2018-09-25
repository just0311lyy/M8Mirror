//
//  M8AdminViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8AdminViewController.h"
#import "HeadImageViewCell.h"
#import "AdminViewCell.h"
@interface M8AdminViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) HeadImageViewCell *headCell;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *alertPopview;
@property (nonatomic, strong) NSString *imageName;
@end

@implementation M8AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
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
//    _oneSettings = [NSArray arrayWithObjects:@"产品网络关系",@"资料下载",@"注册到机构", nil];
//    _twoSettings = [NSArray arrayWithObjects:@"备份",@"还原", nil];
}

-(void)initWithTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"adminCell"];
    
    _alertPopview = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H-65, SCREEN_W, 1)];
    [self.view addSubview:_alertPopview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"adminCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.section) {
        case 0:
        {
            _headCell = [[HeadImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            _headCell.headImgView.image = [UIImage imageNamed:@"default_head.png"];
            return _headCell;
        }
            break;
        case 1:
        {
            AdminViewCell *viewCell = [[AdminViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            if (indexPath.row ==0) {
                viewCell.titleLb.text = @"类别";
                viewCell.detailLb.text = @"admin";
            }else if(indexPath.row ==1){
                viewCell.titleLb.text = @"账户名称";
                viewCell.detailLb.text = @"admin";
            }else{
                viewCell.titleLb.text = @"昵称";
                viewCell.detailLb.text = @"系统管理员";
            }
            return viewCell;
        }
        default:
            return nil;
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        [self showAlertView];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return CGFLOAT_MIN;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [HeadImageViewCell getCellHeight];
    if (indexPath.section == 0) {
        return [HeadImageViewCell getCellHeight];
    }else{
        return [AdminViewCell getCellHeight];
    }
}

////初始化UIImagePickerController
//UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
////获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
////获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
////获取方方式3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
//PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//方式1
////允许编辑，即放大裁剪
//PickerImage.allowsEditing = YES;
////自代理
//PickerImage.delegate = self;
////页面跳转
//[self presentViewController:PickerImage animated:YES completion:nil];
//开始选择照片

#pragma mark - HeadImageViewCellDelegate
-(void)showAlertView{
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectPhotoWithType:0];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction: [UIAlertAction actionWithTitle: @"从相册获取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectPhotoWithType:1];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *popover = alert.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = _headCell;
        popover.sourceRect = _headCell.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)selectPhotoWithType:(int)type {
    if (type == 2) {
        NSLog(@"取消");
    }else{
        UIImagePickerController *ipVC = [[UIImagePickerController alloc] init];
        //设置跳转方式
        ipVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if (type == 0) {
            NSLog(@"相机");
            BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
            if (!isCamera) {
                NSLog(@"没有摄像头");
                if (_errorHandle) {
                    _errorHandle(@"没有摄像头");
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                return ;
            }else{
                ipVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
        }else{
            NSLog(@"相册");
            ipVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        [self presentViewController:ipVC animated:YES completion:nil];
    }
}

#pragma mark -----------------imagePickerController协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info = %@",info);
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (image == nil) {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    //图片旋转
    if (image.imageOrientation != UIImageOrientationUp) {
        //图片旋转
        image = [self fixOrientation:image];
    }
    if (_imageName==nil || _imageName.length == 0) {
        //获取当前时间,生成图片路径
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *dateStr = [formatter stringFromDate:date];
        _imageName = [NSString stringWithFormat:@"photo_%@.png",dateStr];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(selectPhotoManagerDidFinishImage:)]) {
//        [_delegate selectPhotoManagerDidFinishImage:image];
//    }
//    
//    if (_successHandle) {
//        _successHandle(self,image);
//    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    if (_delegate && [_delegate respondsToSelector:@selector(selectPhotoManagerDidError:)]) {
//        [_delegate selectPhotoManagerDidError:nil];
//    }
//    if (_errorHandle) {
//        _errorHandle(@"撤销");
//    }
}

#pragma mark 图片处理方法
//图片旋转处理
- (UIImage *)fixOrientation:(UIImage *)aImage {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - buttonAction
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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

//
//  M8ContentEditViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8ContentEditViewController.h"
#import "NSString+Wrapper.h"
@interface M8ContentEditViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)UITextField *detailText;
@property (strong, nonatomic)NSString *describeString;
@end

@implementation M8ContentEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    UIView *importView = [[UIView alloc] initWithFrame:CGRectMake(0,64 + 20, SCREEN_W,60)];
    importView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:importView];
    
    _detailText = [[UITextField alloc] initWithFrame:CGRectMake(20,0,SCREEN_W - 40,60)];
    if (![_contentString isEqualToString:@""]) {
        _detailText.text = _contentString;
    }
    [_detailText setDelegate:self];
    //    _detailText.backgroundColor = [UIColor whiteColor];
    _detailText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
    _detailText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [importView addSubview:_detailText];
    
    //提示文字
    CGFloat describeW = SCREEN_W - 80;
    CGFloat describeFond = 20;
//    _describeString = @"提示性文字";
    switch (_buttonTag) {
        case 11:
        {
            _describeString = @"请输入中文或者英文姓名";
        }
            break;
        case 14:
        {
            [_detailText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            _detailText.keyboardType = UIKeyboardTypeNumberPad;
            _describeString = @"请输入以'1'开头的11位数字联系电话";
        }
            break;
        case 15:
        {
            _describeString = @"请输入以'@**.**'格式的标准邮箱地址";
        }
            break;
        case 16:
        {
            _describeString = @"请输入居住地址";
        }
            break;
        case 17:
        {
            _describeString = @"请输入所从事职业";
        }
            break;
        case 18:
        {
            _describeString = @"请输入业余爱好";
        }
            break;
        case 20:
        {
            _describeString = @"请输入曾使用过的护肤产品名称,用','号隔开";
        }
            break;
        default:
            break;
    }
    CGFloat describeH = [NSString calculateRowHeightWithString:_describeString andWidth:describeW fontSize:describeFond];
    UILabel *describeLl = [[UILabel alloc] initWithFrame:CGRectMake(40,CGRectGetMaxY(importView.frame) + 20, describeW,describeH)];
    [describeLl setTextColor:[UIColor whiteColor]];
    describeLl.font = [UIFont systemFontOfSize:describeFond];
    [describeLl setTextAlignment:NSTextAlignmentLeft];
    [describeLl setText:_describeString];
    [describeLl setNumberOfLines:0];
    [describeLl setLineBreakMode:NSLineBreakByWordWrapping];
    [self.view addSubview:describeLl];
}

-(void)initWithNavBar{
    //    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:22]};
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    //    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

//限制输入框只能输入11位
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField == _detailText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

#pragma mark - buttonAction
//取消按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
    //验证输入是否合法
    switch (_buttonTag) {
        case 14:
        {
            if (![NSString checkTelNumber:_detailText.text]) {
                [self showAlertViewWithText:@"请输入'1'开头的11位数字的正确手机号格式"];
            }
        }
            break;
        case 15:
        {
            if (![NSString validateEmail:_detailText.text]){
                [self showAlertViewWithText:@"请输入'@**.**'的标准格式邮箱地址"];
            }
        }
            break;
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(importWithString:andButtonTag:)]) {
        [self.delegate importWithString:_detailText.text andButtonTag:_buttonTag];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

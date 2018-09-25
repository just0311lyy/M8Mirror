//
//  PasswordImportView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "PasswordImportView.h"
@interface PasswordImportView ()<UITextFieldDelegate>

@end

@implementation PasswordImportView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andPlaceholder:(NSString *)placeholderStr{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 20;
        //标题
        CGFloat title_w = 160;
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(space,0,title_w, height)];
        [titleLb setFont:[UIFont systemFontOfSize:22]];
        titleLb.text = title;
        [titleLb setTextAlignment:NSTextAlignmentLeft];
        [titleLb setNumberOfLines:0];
        [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:titleLb];
        //输入框
        UITextField *importText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame)+space, 0, width - CGRectGetMaxX(titleLb.frame)+space, height)];
        [importText setDelegate:self];
        [importText setPlaceholder:placeholderStr];
        importText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
        importText.autocapitalizationType = UITextAutocapitalizationTypeNone; //不自动大写
        //    _accountText.textAlignment = UITextAlignmentLeft;
        [self addSubview:importText];
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLb.frame), height - 1,width - space, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        [self addSubview:lineView];
    }
    return self;
}

//-(void)leftBtnAction{
//    if ([self.delegate respondsToSelector:@selector(leftButtonClick)]) {
//        [self.delegate leftButtonClick];
//    }
//}

@end

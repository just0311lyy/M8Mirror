//
//  ProductKindView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductKindView.h"

#define cellHeight 50
@interface ProductKindView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *kindArr;
    CGFloat viewHeight;
}

@property(nonatomic,strong) UIControl *overlayView;
@property(nonatomic,assign) NSInteger currentIndex;
@end
@implementation ProductKindView

-(id)initKindViewWithArr:(NSArray *)arr current:(NSInteger)currentIndex{
//    viewHeight = arr.count>7?cellHeight*7:cellHeight*arr.count;
    viewHeight = cellHeight*arr.count;
    if (self =[super initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, viewHeight)]) {
        kindArr = arr;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, viewHeight)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        _currentIndex = currentIndex;
        [self addSubview:tableView];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return kindArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *kindLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_W - 100)/2, 0, 100, cellHeight)];
    [kindLabel setTextColor:[UIColor blackColor]];
    kindLabel.font = [UIFont systemFontOfSize:24];
    [kindLabel setTextAlignment:NSTextAlignmentCenter];
    [kindLabel setNumberOfLines:0];
    [kindLabel setLineBreakMode:NSLineBreakByWordWrapping];
    kindLabel.text = kindArr[indexPath.row];
    [cell.contentView addSubview:kindLabel];

    if (indexPath.row == _currentIndex) {
        [kindLabel setTextColor:LOGO_COLOR];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.kindSelectIndex) {
        self.kindSelectIndex(indexPath.row);
        [self fadeOut];
    }
}

- (UIControl *)overlayView{
    if (!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_overlayView addTarget:self action:@selector(fadeOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _overlayView;
}

- (void)show:(UIView*)showIn{
    [showIn addSubview:self.overlayView];
    [showIn addSubview:self];
    self.frame = CGRectMake(0, - viewHeight, SCREEN_W, viewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 64, SCREEN_W, viewHeight);
    }];
}

- (void)fadeOut
{
    if (self.kindViewFadeOut) {
        self.kindViewFadeOut();
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, - viewHeight, SCREEN_W, viewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
    }];
}

@end

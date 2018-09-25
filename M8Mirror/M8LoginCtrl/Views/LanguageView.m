//
//  LanguageView.m
//  M8Mirror
//
//  Created by 卢升 on 2018/3/28.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LanguageView.h"
#import "CountryModel.h"
#import "LanguageViewCell.h"

#define cellHeight [LanguageViewCell getCellHeight]

@interface LanguageView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *languageArr;
    CGFloat viewHeight;
}

@property(nonatomic,strong) UIControl *overlayView;
@property(nonatomic,assign) NSInteger currentIndex;
@end

@implementation LanguageView

-(id)initLanguageViewWithArr:(NSArray *)arr current:(NSInteger)currentIndex{
//    viewHeight = arr.count>7?cellHeight*7:cellHeight*arr.count;
    viewHeight = cellHeight*arr.count;
    if (self =[super initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, viewHeight)]) {
        languageArr = arr;
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
    return languageArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LanguageViewCell getCellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *identifier = @"languageCell";
    LanguageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LanguageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CountryModel *model = languageArr[indexPath.row];
    cell.countryNameLb.text = model.countryName;
    cell.countryImage.image = [UIImage imageNamed:model.imageName];
    UIImage *selectedImage = [UIImage imageNamed:@"round_unselected.png"];
    if (indexPath.row == _currentIndex) {
        selectedImage = [UIImage imageNamed:@"round_selected.png"];
    }
    cell.selectedImage.image = selectedImage;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.languageSelectIndex) {
        self.languageSelectIndex(indexPath.row);
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
    self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, viewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREEN_H-cellHeight*languageArr.count, SCREEN_W, viewHeight);
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, viewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

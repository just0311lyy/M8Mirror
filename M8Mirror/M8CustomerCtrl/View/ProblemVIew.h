//
//  ProblemVIew.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/18.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemVIew : UIView
-(instancetype)initWithFrame:(CGRect)frame/* withProblem:(NSString *)problem andStarLevel:(NSString *)levelString*/;
@property(nonatomic,strong)UILabel *problemLb;
//@property(nonatomic,strong)NSString *levelString;
@property(nonatomic,strong)UILabel *levelLb;
@property(nonatomic,strong)UILabel *starsLb;
@end

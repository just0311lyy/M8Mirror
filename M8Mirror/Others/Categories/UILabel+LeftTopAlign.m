//
//  UILabel+LeftTopAlign.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "UILabel+LeftTopAlign.h"

@implementation UILabel (LeftTopAlign)
- (void)textLeftTopAlign{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame),999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGRect dateFrame = CGRectMake(20,0, CGRectGetWidth(self.frame), labelSize.height);
    self.frame = dateFrame;
}
@end

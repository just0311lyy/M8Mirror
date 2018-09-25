//
//  LYXMLElement.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/29.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYXMLElement.h"

@implementation LYXMLElement

@synthesize name,text,attributes,subElements,parent;

-(NSMutableArray *)subElements{
    if(subElements == nil){
        subElements = [[NSMutableArray alloc] init];
    }
    return subElements;
}

@end

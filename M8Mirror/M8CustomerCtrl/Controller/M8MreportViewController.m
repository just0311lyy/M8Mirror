//
//  M8MreportViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/9.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "M8MreportViewController.h"
#import "ImageWithStringView.h"
#import "PhotoScorllView.h"
#import "ProblemVIew.h"
#import "DescribeView.h"
#import "UILabel+LeftTopAlign.h"
#import "NSString+Wrapper.h"
#import "FSCustomButton.h"
#import "MOCompareViewController.h"
#import "ReportProductsView.h"
#import "SugProductsShowViewController.h"
//绘制折线图
#import "YKLineChartView.h"
#import "YKUIConfig.h"
#import "YKLineDataObject.h"

#define content_font 18
#define space 10
#define titleHeight 40
#define title_color UIColorFromRGB(0x00a7d3)
@interface M8MreportViewController ()
<UIScrollViewDelegate,ReportProductsViewDelegate>
@property (nonatomic ,strong) UIImageView *headImgView;  //头像
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) ImageWithStringView *birthView;
@property (nonatomic ,strong) ImageWithStringView *phoneView;
@property (nonatomic ,strong) ImageWithStringView *dateView;
@property (nonatomic ,strong) PhotoScorllView *photoScrollView;  //照片视图
@property (nonatomic ,strong) UIScrollView *reportScrollView;
//问题视图
@property (nonatomic ,strong) UIView *resultView;
@property (nonatomic ,assign) NSInteger problemNo;
//护肤模块视图
@property (nonatomic ,strong) UIView *suggestionView;
@property (nonatomic ,strong) NSString *suggestStr;  //护肤建议内容
@property (nonatomic ,assign) CGFloat suggestStr_h;  //护肤建议内容高度
@property (nonatomic ,assign) CGFloat suggestion_h;  //护肤模块高度
//肌龄
@property (nonatomic ,strong) UIView *skinAgeView;
@property (nonatomic ,strong) YKLineChartView *chartView;
//肤色
@property (nonatomic ,strong) UIView *skinColorView;
@property (nonatomic ,strong) NSString *skinColorStr;  //肤色内容
@property (nonatomic ,assign) CGFloat skinColorStr_h;  //肤色内容高度
@property (nonatomic ,assign) CGFloat skinColor_h;  //肤色模块高度
//肌质
@property (nonatomic ,strong) UIView *skinQualityView;
@property (nonatomic ,strong) NSString *skinQualityStr;  //肤质内容
@property (nonatomic ,assign) CGFloat skinQualityStr_h;  //肤质内容高度
@property (nonatomic ,assign) CGFloat skinQuality_h;  //肤质模块高度
//推荐产品
@property (nonatomic ,strong) NSString *maokongStr;
@property (nonatomic ,assign) CGFloat maokongStr_h;
@property (nonatomic ,strong) NSString *douDouStr;
@property (nonatomic ,assign) CGFloat douDouStr_h;
@end

@implementation M8MreportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNavBar{
    [super initNavBar];
    //导航栏右按钮
    [_rightNavBarBtn setTitle:@"返回主页" forState:UIControlStateNormal];
    _rightNavBarBtn.frame = CGRectMake(0, 0,GetLogicPixelX(126),GetLogicPixelX(36));
    if (!_isFromInstrument) {

    }else{
        _leftNavBarBtn.hidden = YES;
//        [self.navigationController.navigationItem setHidesBackButton:YES];
//        [self.navigationItem setHidesBackButton:YES];
//        [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    }
    
}

-(void)initData{
    [super initData];
}
//每个模块高度的计算，计算出滑动视图的真实内容高度
-(CGFloat)getReportScrollViewContentHeight{
    //护肤建议栏高度
    _suggestStr = @"你属于亲熟龄的混合型的肌肤。1.混合型皮肤敏感且皮脂腺活跃。主要的肌肤问题为黑头、痤疮以及两颊干燥。2.要避免暴晒、过热和过潮的环境以及出现在气温骤变的环境。3.在清结上选择温和控油的洁面产品扫去油脂。4.已经出现皱纹的肌肤，应该使用抗氧产品减缓油脂氧化，改善皱纹。";
    _suggestStr_h = [NSString calculateRowHeightWithString:_suggestStr andWidth:(SCREEN_W-4*space) fontSize:content_font];
    _suggestion_h = 2*space + titleHeight + _suggestStr_h;  //护肤建议高度
    //肤色栏高度
    _skinColorStr = @"你属于自然健康的肤色，是亚洲人最常见的肤色，平时注意好防晒工作和日常的补水保湿即可。如有美白、提亮肤色的需求，也可以使用具有美白功效的护肤品。";
    _skinColorStr_h = [NSString calculateRowHeightWithString:_skinColorStr andWidth:(SCREEN_W-4*space) fontSize:content_font];
    _skinColor_h = titleHeight + (titleHeight+5*space) + (2*space+ _skinColorStr_h);
    //肤质
    _skinQualityStr = @"你属于T区偏油，两颊偏干的混合型肤质，最好分区进行针对性保养；日常清洁建议选用较温和的洁面用品，同时定期深层清洁T区等油脂分泌较多的部位。除此之外还需要注意补水保湿，调节肌肤水油平衡";
    _skinQualityStr_h = [NSString calculateRowHeightWithString:_skinQualityStr andWidth:(SCREEN_W-4*space) fontSize:content_font];
    CGFloat face_h = 90 + 2*space + titleHeight/2;  //90:肤质图片高度
    _skinQuality_h = titleHeight + (2*space +face_h) + (2*space + _skinQualityStr_h);  //肤质高度
    //产品推荐 推荐个数 x 12*space + 每个的内容高度
    //    _maokongStr = @"建议使用温和控油的洁面产品，早晚两次定期清理洁面部尤其是T区的油脂，缓解油脂氧化形成黑头的速度。U区则推荐使用温和滋润型的洁面产品。";
    //    _maokongStr_h = [NSString calculateRowHeightWithString:_maokongStr andWidth:(SCREEN_W-2*space) fontSize:18];
    //    _douDouStr = @"由于皮脂腺活跃，皮脂分泌旺盛，毛囊皮脂腺导管角化异常，面部出油、粉刺、青春痘等问题会一直伴随着你。建议护肤时注意面部清洁和防晒，生活中注意作息规律，饮食清淡。";
    //    _douDouStr_h = [NSString calculateRowHeightWithString:_douDouStr andWidth:(SCREEN_W-2*space) fontSize:18];
    //    CGFloat productSuggest_h = (13*space + _maokongStr_h) + (13*space + _douDouStr_h);
    _problemNo = 9;
    //导航栏高度 + 头 + 照片 + 问题 + 护肤建议高度 + 肌龄 + 肤色 + 肤质 + 产品推荐
    CGFloat contentHeight = 64 + SCREEN_H/3 + 260 + _problemNo*60 + _suggestion_h + 200 + _skinColor_h + _skinQuality_h /*+ productSuggest_h */;
    return contentHeight;
}

-(void)initView{
    //背景scrollview
    CGFloat view_H = [self getReportScrollViewContentHeight];
    _reportScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
    _reportScrollView.contentSize = CGSizeMake(SCREEN_W,view_H);
    //    reportScrollView.backgroundColor = UIColorFromRGB(0xedf0f3);
    _reportScrollView.delegate = self;
    _reportScrollView.clipsToBounds = NO; //将其子视图超出的部分显现出来
    _reportScrollView.pagingEnabled = NO; //是否分页效果
    _reportScrollView.showsHorizontalScrollIndicator = NO; //是否显示水平滚动条
    _reportScrollView.showsVerticalScrollIndicator = YES;
    _reportScrollView.bounces = NO; //滑动到屏幕边缘则禁止继续滑动
    [self.view addSubview:_reportScrollView];
    
    CGFloat head_H = GetLogicPixelX(600);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, head_H)];
    headView.backgroundColor = UIColorFromRGB(0xedf0f3);
    [_reportScrollView addSubview:headView];
    //头部蓝色背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, head_H/4)];
    bgView.backgroundColor = LOGO_COLOR;
    [headView addSubview:bgView];
    //头像
    CGFloat img_h = head_H*2/5;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_W - img_h)/2,GetLogicPixelX(20), img_h, img_h)];
    _headImgView.image = [UIImage imageWithBase64String:_currentCustomer.headImgOfBase64String];
    _headImgView.layer.cornerRadius = img_h/2;
    _headImgView.layer.borderWidth = GetLogicPixelX(5);
    _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headImgView.layer setMasksToBounds:YES];
    [headView addSubview:_headImgView];

    //客户姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_W - CGRectGetWidth(_headImgView.frame))/2,CGRectGetMaxY(_headImgView.frame) + GetLogicPixelX(10), CGRectGetWidth(_headImgView.frame),GetLogicPixelX(50))];
    _nameLabel.font = [UIFont systemFontOfSize:GetLogicFont(18)];
    _nameLabel.text = _currentCustomer.name;
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setNumberOfLines:0];
    [_nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [headView addSubview:_nameLabel];
    //客户生日
    CGFloat number_w = SCREEN_W/2;
    _birthView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(GetLogicPixelX(40), CGRectGetMaxY(_nameLabel.frame) + GetLogicPixelX(10),number_w, CGRectGetHeight(_nameLabel.frame)) andImage:[UIImage imageNamed:@"birthday.png"]];
    _birthView.numberLb.text = _currentCustomer.birthday;
    [headView addSubview:_birthView];
    //客户电话
    _phoneView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_birthView.frame), CGRectGetMaxY(_birthView.frame) + GetLogicPixelX(10),CGRectGetWidth(_birthView.frame), CGRectGetHeight(_birthView.frame)) andImage:[UIImage imageNamed:@"phone.png"]];
    _phoneView.numberLb.text = _currentCustomer.phoneNumber;
    [headView addSubview:_phoneView];
    //报告日期
    _dateView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_birthView.frame), CGRectGetMaxY(_phoneView.frame) + GetLogicPixelX(10),CGRectGetWidth(_phoneView.frame), CGRectGetHeight(_phoneView.frame)) andImage:[UIImage imageNamed:@"birthday.png"]];
    _dateView.numberLb.text = [_currentReport.reportDate substringWithRange:NSMakeRange(0, 10)];
    [headView addSubview:_dateView];
    
    //对照分析
    CGFloat compareBtn_w = GetLogicPixelX(170);
    UIImage *selectImg = [[UIImage scaleImage:[UIImage imageNamed:@"takephoto.png"] toSize:CGSizeMake(GetLogicPixelX(86), GetLogicPixelX(86))] imageWithTintColor:LOGO_COLOR];
    FSCustomButton *compareBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(SCREEN_W - compareBtn_w - GetLogicPixelX(40),CGRectGetMinY(_birthView.frame),compareBtn_w,compareBtn_w)];
    compareBtn.adjustsTitleTintColorAutomatically = YES;
    [compareBtn setTintColor:LOGO_COLOR];
    compareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:GetLogicFont(14)];
    [compareBtn setTitle:@"对照分析" forState:UIControlStateNormal];
    [compareBtn setImage:selectImg forState:UIControlStateNormal];
    compareBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
    compareBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
    [compareBtn addTarget:self action:@selector(compareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:compareBtn];
    
    CGFloat photo_h = 260;
    _photoScrollView = [[PhotoScorllView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), SCREEN_W, photo_h)];
    if (_currentReport.oneImgPathStr) {
        _photoScrollView.WLImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.oneImgPathStr];
    }
    if (_currentReport.twoImgPathStr) {
        _photoScrollView.PFLHImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.twoImgPathStr];
    }
    if (_currentReport.threeImgPathStr) {
        _photoScrollView.HSQImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.threeImgPathStr];
    }
    if (_currentReport.fourImgPathStr) {
        _photoScrollView.ZSQImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.fourImgPathStr];
    }
    if (_currentReport.fiveImgPathStr) {
        _photoScrollView.ZWXBImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.fiveImgPathStr];
    }
    
    if (_currentReport.sixImgPathStr) {
        _photoScrollView.SIXImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.sixImgPathStr];
    }
    if (_currentReport.sevenImgPathStr) {
        _photoScrollView.SEVENImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.sevenImgPathStr];
    }
    if (_currentReport.eightImgPathStr) {
        _photoScrollView.EIGHTImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.eightImgPathStr];
    }
    if (_currentReport.nineImgPathStr) {
        _photoScrollView.NINEImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentReport.nineImgPathStr];
    }
    
    [_reportScrollView addSubview:_photoScrollView];
    
    [self initWithProblemView];  //ploblemView
    //护肤建议
    [self initWithSuggestionView];
    //肌龄(岁)
    [self initWithSkinAgeView];
    //肤色
    [self initWithSkinColorView];
    //肤质
    [self initWithSkinQualityView];
    //产品推荐
    //    [self initWithProductsSuggestionView];
    
}

-(void)initWithProblemView{
    CGFloat view_h = 60;
    CGFloat result_h = _problemNo * view_h;
    _resultView = [[UIView alloc] initWithFrame:CGRectMake(space, CGRectGetMaxY(_photoScrollView.frame) + space, SCREEN_W - 2*space, result_h)];
    _resultView.layer.shadowOpacity = 0.7;// 阴影透明度
    _resultView.layer.shadowColor = UIColorFromRGB(0xe6e8eb).CGColor;// 阴影的颜色
    _resultView.layer.shadowRadius = space;// 阴影扩散的范围控制
    _resultView.layer.shadowOffset = CGSizeMake(space,space);// 阴影的范围
    _resultView.layer.cornerRadius = 5;
    _resultView.layer.borderWidth = 2;
    _resultView.layer.borderColor = UIColorFromRGB(0xe6e8eb).CGColor;
    [_reportScrollView addSubview:_resultView];
    
    for (int i=0; i<(_problemNo-3); i++) {
        ProblemVIew *problemView = [[ProblemVIew alloc] initWithFrame:CGRectMake(0,i*view_h, CGRectGetWidth(_resultView.frame), view_h)];
        switch (i) {
            case 0:
            {
                problemView.problemLb.text = @"毛孔粗大1028个";
                problemView.levelLb.text = @"正常";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            case 1:
            {
                problemView.problemLb.text = @"痘痘/痘印8个";
                problemView.levelLb.text = @"一般";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            case 2:
            {
                problemView.problemLb.text = @"黑头5个";
                problemView.levelLb.text = @"轻度";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            case 3:
            {
                problemView.problemLb.text = @"粉刺1000个";
                problemView.levelLb.text = @"正常";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            case 4:
            {
                problemView.problemLb.text = @"问题五";
                problemView.levelLb.text = @"轻度";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            case 5:
            {
                problemView.problemLb.text = @"问题六";
                problemView.levelLb.text = @"重度";
                problemView.starsLb.text = [self starsWithLevel:problemView.levelLb.text];
            }
                break;
            default:
                break;
        }
        [_resultView addSubview:problemView];
        
        UIButton *problemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,i*view_h, CGRectGetWidth(_resultView.frame), view_h)];
        [problemBtn addTarget:self action:@selector(problemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        problemBtn.tag = 10+i;
        [_resultView addSubview:problemBtn];
    }
    
    DescribeView *describeOneView = [[DescribeView alloc] initWithFrame:CGRectMake(0, 6 * view_h, CGRectGetWidth(_resultView.frame), view_h) withDescribe:@"肤质" andContent:@"混合型"];
    [_resultView addSubview:describeOneView];
    
    DescribeView *describeTwoView = [[DescribeView alloc] initWithFrame:CGRectMake(0, 7 * view_h, CGRectGetWidth(_resultView.frame), view_h) withDescribe:@"肤色" andContent:@"小麦"];
    [_resultView addSubview:describeTwoView];
    
    DescribeView *describeThreeView = [[DescribeView alloc] initWithFrame:CGRectMake(0, 8 * view_h, CGRectGetWidth(_resultView.frame), view_h) withDescribe:@"肌龄" andContent:@"23岁"];
    [_resultView addSubview:describeThreeView];
}

-(void)initWithSuggestionView{
    _suggestionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_resultView.frame) + 2*space, SCREEN_W, _suggestion_h)];
    [_reportScrollView addSubview:_suggestionView];
    
    //标题
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,0, SCREEN_W - 2*2*space, titleHeight)];
    [titleLb setFont:[UIFont systemFontOfSize:21]];
    [titleLb setText:@"护肤建议"];
    [titleLb setTextAlignment:NSTextAlignmentLeft];
    [titleLb setNumberOfLines:0];
    [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_suggestionView addSubview:titleLb];
    
    UILabel *contentLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,CGRectGetMaxY(titleLb.frame), SCREEN_W - 2*2*space,_suggestStr_h)];
    [contentLb setFont:[UIFont systemFontOfSize:content_font]];
    [contentLb setTextColor:UIColorFromRGB(0x4c4c4c)];
    [contentLb setText:_suggestStr];
    [contentLb setTextAlignment:NSTextAlignmentLeft];
    [contentLb setNumberOfLines:0];
    [contentLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_suggestionView addSubview:contentLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _suggestion_h - 1, SCREEN_W, 1)];
    //    lineView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    lineView.backgroundColor = LOGO_COLOR;
    [_suggestionView addSubview:lineView];
}

-(void)initWithSkinAgeView{
    CGFloat skin_h = 200;  //护肤建议高度
    _skinAgeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_suggestionView.frame), SCREEN_W, skin_h)];
    _skinAgeView.backgroundColor = [UIColor yellowColor];
    [_reportScrollView addSubview:_skinAgeView];
    
    if (_chartView == nil) {
        _chartView = [[YKLineChartView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(_skinAgeView.frame),CGRectGetHeight(_skinAgeView.frame))];
    }
    [_skinAgeView addSubview:_chartView];
    
    //y轴
    YKUIConfig *config = [YKUIConfig new];
    config.yDescFront = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
    config.yDescColor = UIColorFromRGB(0xc1c1c1);
    config.ylineColor =  [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:0.3f];
    
    //x轴
    config.xDescFront = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0f];
    config.xDescColor = UIColorFromRGB(0xc1c1c1);
    //线
    config.lineWidth = 2;
    config.lineColor = [UIColor orangeColor];
    config.circleWidth = 3;
    
    YKLineDataObject *dataObject = [YKLineDataObject new];
    dataObject.xDescriptionDataSource = @[@"02.13",@"04.10",@"06.15",@"07.25",@"08.22"];
    dataObject.showNumbers = @[@(24.45),@(22.85),@(19.68),@(21.68),@(21.00)];
    [_chartView setupDataSource:dataObject withUIConfgi:config];
}

-(void)initWithSkinColorView{
    _skinColorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_skinAgeView.frame) + 2*space, SCREEN_W, _skinColor_h)];
    [_reportScrollView addSubview:_skinColorView];
    
    //肤色
    CGFloat title_w = 60;
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,0,title_w, titleHeight - 10)];
    [titleLb setFont:[UIFont systemFontOfSize:20]];
    [titleLb setText:@"肤色"];
    [titleLb setTextColor:[UIColor whiteColor]];
    [titleLb setBackgroundColor:title_color];
    [titleLb setTextAlignment:NSTextAlignmentCenter];
    [titleLb setNumberOfLines:0];
    [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinColorView addSubview:titleLb];
    //正常
    UILabel *stateLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame)-(titleHeight - 10)/2,CGRectGetMinY(titleLb.frame),CGRectGetWidth(titleLb.frame) + 20, CGRectGetHeight(titleLb.frame))];
    [stateLb setFont:[UIFont systemFontOfSize:20]];
    [stateLb setText:@"自然"];
    [stateLb setTextColor:title_color];
    stateLb.layer.cornerRadius = (titleHeight-10)/2;
    stateLb.layer.borderWidth = 1;
    stateLb.layer.borderColor = title_color.CGColor;
    [stateLb setTextAlignment:NSTextAlignmentCenter];
    [stateLb setNumberOfLines:0];
    [stateLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinColorView addSubview:stateLb];
    
    UIView *colorBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLb.frame)+4*space, SCREEN_W ,titleHeight+space)];
    [_skinColorView addSubview:colorBgView];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLb.frame)+space, 0, SCREEN_W - 2*3*space,titleHeight/2)];
    colorView.layer.cornerRadius = CGRectGetHeight(colorView.frame)/2;
    colorView.clipsToBounds = YES;
    [colorBgView addSubview:colorView];
    //颜色
    CGFloat color_w = CGRectGetWidth(colorView.frame)/6;
    for (int i = 0; i<6; i++) {
        UIView *oneColorView = [[UIView alloc] initWithFrame:CGRectMake(i * color_w, 0, color_w, titleHeight/2)];
        UILabel *oneColorLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(colorView.frame)+CGRectGetMinX(oneColorView.frame),CGRectGetMaxY(oneColorView.frame)+space,CGRectGetWidth(oneColorView.frame),CGRectGetHeight(oneColorView.frame))];
        [oneColorLb setFont:[UIFont systemFontOfSize:16]];
        [oneColorLb setTextColor:UIColorFromRGB(0x969696)];
        [oneColorLb setTextAlignment:NSTextAlignmentCenter];
        [oneColorLb setNumberOfLines:0];
        [oneColorLb setLineBreakMode:NSLineBreakByWordWrapping];
        switch (i) {
            case 0:
                oneColorView.backgroundColor = UIColorFromRGB(0xfbead4);
                [oneColorLb setText:@"透白"];
                break;
            case 1:
                oneColorView.backgroundColor = UIColorFromRGB(0xfedcb0);
                [oneColorLb setText:@"偏白"];
                break;
            case 2:
                oneColorView.backgroundColor = UIColorFromRGB(0xf0c996);
                [oneColorLb setText:@"自然"];
                break;
            case 3:
                oneColorView.backgroundColor = UIColorFromRGB(0xe1b67a);
                [oneColorLb setText:@"偏暗"];
                break;
            case 4:
                oneColorView.backgroundColor = UIColorFromRGB(0xba9059);
                [oneColorLb setText:@"暗层"];
                break;
            case 5:
                oneColorView.backgroundColor = UIColorFromRGB(0x693700);
                [oneColorLb setText:@"欧黑"];
                break;
            default:
                break;
        }
        [colorView addSubview:oneColorView];
        [colorBgView addSubview:oneColorLb];
    }
    
    UILabel *contentLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,CGRectGetMaxY(colorBgView.frame)+2*space, SCREEN_W - 2*2*space,_skinColorStr_h)];
    [contentLb setFont:[UIFont systemFontOfSize:content_font]];
    [contentLb setTextColor:UIColorFromRGB(0x4c4c4c)];
    [contentLb setText:_skinColorStr];
    [contentLb setTextAlignment:NSTextAlignmentLeft];
    [contentLb setNumberOfLines:0];
    [contentLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinColorView addSubview:contentLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _skinColor_h - 1, SCREEN_W, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [_skinColorView addSubview:lineView];
}

-(void)initWithSkinQualityView{
    _skinQualityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_skinColorView.frame) + 2*space, SCREEN_W, _skinQuality_h)];
    [_reportScrollView addSubview:_skinQualityView];
    
    //肤质
    CGFloat title_w = 60;
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,0,title_w, titleHeight - 10)];
    [titleLb setFont:[UIFont systemFontOfSize:content_font + 2]];
    [titleLb setText:@"肤质"];
    [titleLb setTextColor:[UIColor whiteColor]];
    [titleLb setBackgroundColor:title_color];
    [titleLb setTextAlignment:NSTextAlignmentCenter];
    [titleLb setNumberOfLines:0];
    [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinQualityView addSubview:titleLb];
    //混合型
    UILabel *stateLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame)-(titleHeight - 10)/2,CGRectGetMinY(titleLb.frame),CGRectGetWidth(titleLb.frame) + 45, CGRectGetHeight(titleLb.frame))];
    [stateLb setFont:[UIFont systemFontOfSize:content_font + 2]];
    [stateLb setText:@"混合型"];
    [stateLb setTextColor:title_color];
    stateLb.layer.cornerRadius = (titleHeight-10)/2;
    stateLb.layer.borderWidth = 1;
    stateLb.layer.borderColor = title_color.CGColor;
    [stateLb setTextAlignment:NSTextAlignmentCenter];
    [stateLb setNumberOfLines:0];
    [stateLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinQualityView addSubview:stateLb];
    
    CGFloat face_h = 90 + 2*space + titleHeight/2;  //90肤质图片高度
    UIView *faceImgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLb.frame)+2*space, SCREEN_W ,face_h)];
    [_skinQualityView addSubview:faceImgView];
    
    //肤质图片 w=20  h=50
    CGFloat img_w = 70;
    CGFloat img_h = 90;
    CGFloat imgView_w = (SCREEN_W - 4*img_w)/5;
    for (int i = 0; i<4; i++) {
        UIImageView *oneImgView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1) * imgView_w + i * img_w,0, img_w,img_h)];
        UILabel *oneImgLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(oneImgView.frame),CGRectGetMaxY(oneImgView.frame)+space,CGRectGetWidth(oneImgView.frame),titleHeight/2)];
        [oneImgLb setFont:[UIFont systemFontOfSize:20]];
        [oneImgLb setTextColor:UIColorFromRGB(0x969696)];
        [oneImgLb setTextAlignment:NSTextAlignmentCenter];
        [oneImgLb setNumberOfLines:0];
        [oneImgLb setLineBreakMode:NSLineBreakByWordWrapping];
        switch (i) {
            case 0:
                oneImgView.backgroundColor = UIColorFromRGB(0xffe7df);
                [oneImgLb setText:@"混合性"];
                break;
            case 1:
                oneImgView.backgroundColor = UIColorFromRGB(0xeeeeee);
                [oneImgLb setText:@"中性"];
                break;
            case 2:
                oneImgView.backgroundColor = UIColorFromRGB(0xeeeeee);
                [oneImgLb setText:@"干性"];
                break;
            case 3:
                oneImgView.backgroundColor = UIColorFromRGB(0xeeeeee);
                [oneImgLb setText:@"油性"];
                break;
            default:
                break;
        }
        [faceImgView addSubview:oneImgView];
        [faceImgView addSubview:oneImgLb];
    }
    
    UILabel *contentLb = [[UILabel alloc] initWithFrame:CGRectMake(2*space,CGRectGetMaxY(faceImgView.frame)+2*space, SCREEN_W - 2*2*space,_skinQualityStr_h)];
    [contentLb setFont:[UIFont systemFontOfSize:content_font]];
    [contentLb setTextColor:UIColorFromRGB(0x4c4c4c)];
    [contentLb setText:_skinQualityStr];
    [contentLb setTextAlignment:NSTextAlignmentLeft];
    [contentLb setNumberOfLines:0];
    [contentLb setLineBreakMode:NSLineBreakByWordWrapping];
    [_skinQualityView addSubview:contentLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _skinQuality_h - 1, SCREEN_W, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [_skinQualityView addSubview:lineView];
}

-(void)initWithProductsSuggestionView{
    ReportProductsView *maoKongView = [[ReportProductsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_skinQualityView.frame), SCREEN_W, 13*space + _maokongStr_h) withNumber:@"1" andContentHeight:_maokongStr_h andContentFont:18];
    maoKongView.titleLb.text = @"毛孔1028个";
    maoKongView.percentLb.text = [NSString stringWithFormat:@"%d\u7684的人都有相同的困扰",65];
    maoKongView.detailLb.text = _maokongStr;
    maoKongView.delegate = self;
    [_reportScrollView addSubview:maoKongView];
    
    ReportProductsView *douDouView = [[ReportProductsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(maoKongView.frame), SCREEN_W, 13*space + _douDouStr_h) withNumber:@"2" andContentHeight:_douDouStr_h andContentFont:18];
    douDouView.titleLb.text = @"痘痘/痘印8个";
    douDouView.percentLb.text = [NSString stringWithFormat:@"%d\u7684的人都有相同的困扰",53];
    douDouView.detailLb.text = _douDouStr;
    douDouView.delegate = self;
    [_reportScrollView addSubview:douDouView];
}

#pragma mark - M8MainTitleViewDelegate
-(void)leftNavBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavBarButtonClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)compareButtonAction{
    MOCompareViewController *comparevc = [[MOCompareViewController alloc] init];
    //    reportvc.title = @"客户报告";
    comparevc.currentCompareCust = _currentCustomer;
    comparevc.currentCompareReport = _currentReport;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:comparevc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

-(void)problemButtonClick:(UIButton *)sender{
    SugProductsShowViewController *spsvc = [[SugProductsShowViewController alloc] init];
    switch (sender.tag) {
        case 10:
        {
            spsvc.productAttrib = @"00,01";
            spsvc.productGrade = @"基础";
            spsvc.productNetId = 111;
        }
            break;
        case 11:
        {
            spsvc.productAttrib = @"01,02";
            spsvc.productGrade = @"基础";
            spsvc.productNetId = 222;
        }
            break;
        case 12:
        {
            spsvc.productAttrib = @"02,03";
            spsvc.productGrade = @"基础";
            spsvc.productNetId = 333;
        }
            break;
        case 13:
        {
            spsvc.productAttrib = @"03,04";
            spsvc.productGrade = @"基础";
            spsvc.productNetId = 444;
        }
            break;
        case 14:
        {
            spsvc.productAttrib = @"05,06";
            spsvc.productGrade = @"基础";
            spsvc.productNetId = 555;
        }
            break;
        default:
            break;
    }
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:spsvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

//#pragma mark -- ReportProductsViewDelegate 推荐产品按钮
//-(void)moreProductsShowClick:(UIButton *)sender{
//    SugProductsShowViewController *spsvc = [[SugProductsShowViewController alloc] init];
//    if (sender.tag == (TAG_REPORT_PROBLEM + 1) ){
//        spsvc.productAttrib = @"00,01";
//        spsvc.productGrade = @"基础";
//        spsvc.productNetId = 111;
//    }else if (sender.tag == (TAG_REPORT_PROBLEM + 2)){
//        spsvc.productAttrib = @"02,03";
//        spsvc.productGrade = @"中端";
//        spsvc.productNetId = 222;
//    }else{
//        NSLog(@"点击了未知");
//    }
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:spsvc animated:YES];
//    [self setHidesBottomBarWhenPushed:YES];
//}

-(NSString *)starsWithLevel:(NSString *)levelString{
    //☆★
    NSString *starsString;
    if ([levelString isEqualToString:@"正常"]) {
        starsString = @"★★★";
    }else if ([levelString isEqualToString:@"一般"] || [levelString isEqualToString:@"轻度"]){
        starsString = @"★★";
    }else{
        starsString = @"★";
    }
    return starsString;
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

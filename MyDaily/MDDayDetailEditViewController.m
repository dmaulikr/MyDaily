//
//  MDDayDetailEditViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/2/7.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayDetailEditViewController.h"
#import "MDThemeColorManager.h"
#import "UIDefine.h"
#import "MDDataBaseManager.h"

@interface MDDayDetailEditViewController ()

@property (nonatomic,assign) MDEmotionType currentEmotionType;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) MDDailyEmotionModel *emotionModel;

@end

@implementation MDDayDetailEditViewController

- (instancetype)initWithEmotionType:(MDEmotionType)emotionType {
    if (self = [super init]) {
        _currentEmotionType = emotionType;
        self.emotionModel = [[MDDailyEmotionModel alloc] init];
        self.emotionModel.dailyEmotion = @(emotionType);
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[MDThemeColorManager sharedInstance] colorForEmotion:_currentEmotionType];
    self.customRightView = UI_IMAGE(@"okbutton");
    [self.view addSubview:self.textView];
    [self hideSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideSubviews];
}

#pragma mark - UI
- (void)hideSubviews {
//    UIView *leftView = [self leftView];
//    UIView *rightView = [self rightView];
//    leftView.hidden = YES;
//    rightView.hidden = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
}

- (void)showSubviews {
//    UIView *leftView = [self leftView];
//    UIView *rightView = [self rightView];
//    leftView.hidden = NO;
//    rightView.hidden = NO;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = NO;
    }];
}

//deal with keyboard
- (void)keyboardWasShown:(NSNotification *)noti {
    NSDictionary *info = [noti userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.textView setFrame:CGRectMake(0, kNaviHeight, self.view.frame.size.width, self.view.frame.size.height - kNaviHeight - kbSize.height)];
}

- (void)keyboardWillHidden:(NSNotification *)noti {
    [self.textView setFrame:CGRectMake(0, kNaviHeight, self.view.frame.size.width, self.view.frame.size.height - kNaviHeight)];
}

//- (void)keyboardDidChangeFrame:(NSNotification *)noti {
//    NSDictionary *info = [noti userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    [self.textView setFrame:CGRectMake(0, kNaviHeight, self.view.frame.size.width, self.view.frame.size.height - kNaviHeight - kbSize.height)];
//}

#pragma mark - actions
- (void)leftButtonAction {
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }
    [self resignFirstResponder];
    UIAlertController *quitAlertVC = [UIAlertController alertControllerWithTitle:@"确认退出" message:@"您还有内容未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"直接退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *saveAndQuitAction = [UIAlertAction actionWithTitle:@"保存并退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self save];
    }];
    [quitAlertVC addAction:quitAction];
    [quitAlertVC addAction:saveAndQuitAction];
    [self presentViewController:quitAlertVC animated:YES completion:nil];
}

- (void)rightButtonAction {
    [self save];
}

- (void)save {
    [[MDDataBaseManager sharedInstance] saveEmotionModel:self.emotionModel complete:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

//- (void)



#pragma mark - getters
-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, kNaviHeight, self.view.frame.size.width, self.view.frame.size.height - kNaviHeight)];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 2.0;
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        _textView.typingAttributes = @{NSParagraphStyleAttributeName:paraStyle,
                                       NSForegroundColorAttributeName:[[MDThemeColorManager sharedInstance] fontColorForEmotion:_currentEmotionType],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15]};
    }
    return _textView;
}

@end

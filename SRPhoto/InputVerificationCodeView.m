//
//  InputVerificationCodeView.m
//  SRPhoto
//
//  Created by 索晓晓 on 2018/8/8.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

#import "InputVerificationCodeView.h"
#import "CodeView.h"

@interface InputVerificationCodeView ()<UITextViewDelegate>
{
    NSInteger flag;
}
@property (nonatomic , strong) CodeView *oneCodeView;
@property (nonatomic , strong) NSMutableArray *codeViews;
@property (nonatomic , strong) UITextView *textview;

@end

@implementation InputVerificationCodeView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i = 0; i < 4; i++) {
            
            CodeView *code = self.oneCodeView;
            code.tag = i;
            [self addSubview:code];
            [self.codeViews addObject:code];
            
        }
        
        [self addSubview:self.textview];
        
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    NSInteger currentIndex = textView.text.length;
    
    switch (currentIndex) {
        case 0:
        {
            [[self.codeViews firstObject] setTitle:@""];
        }
            break;
        case 1:
        case 2:
        case 3:
        {
            //设置当前位数数值
            [[self.codeViews objectAtIndex:currentIndex - 1] setTitle:[textView.text substringWithRange:NSMakeRange(currentIndex - 1, 1)]];
            
            //设置之后的位数成空
            for (int i = (int)currentIndex; i < self.codeViews.count; i++) {
                if (![[[self.codeViews objectAtIndex:i] title] isEqualToString:@"__"]) {
                    [[self.codeViews objectAtIndex:i] setTitle:@""];
                }
            }
        }
            break;
        case 4:
        {
            [[self.codeViews objectAtIndex:3] setTitle:[textView.text substringWithRange:NSMakeRange(3, 1)]];
        }
            break;
            
        default:
            break;
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0) {
        return YES;
    }
    if (textView.text.length >= 4) {
        return NO;
    }
    
    return YES;
}



- (void)tapInputCode:(UIGestureRecognizer *)nor
{
    CodeView *resp = (CodeView *)nor.view;
    flag = resp.tag;
    [self.textview becomeFirstResponder];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat yspace = 40;
    CGFloat xspace = 30;
    CGFloat wh = 50;
    CGFloat xgap = (self.frame.size.width - 2 * xspace - self.codeViews.count * wh)/(self.codeViews.count - 1);
    
    for (int i = 0; i < self.codeViews.count; i++) {
        
        CodeView *cv = self.codeViews[i];
        cv.frame = CGRectMake(xspace + (wh + xgap) * (i%self.codeViews.count),
                              yspace + (wh) * (i/self.codeViews.count),
                              wh,
                              wh);
    }
}

- (NSMutableArray *)codeViews
{
    if (!_codeViews) {
        _codeViews = [NSMutableArray array];
    }
    return _codeViews;
}

- (CodeView *)oneCodeView
{
    _oneCodeView = [[CodeView alloc] init];
    _oneCodeView.layer.cornerRadius = 5;
    _oneCodeView.layer.masksToBounds = YES;
    _oneCodeView.backgroundColor = [UIColor blackColor];
    [_oneCodeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInputCode:)]];
    return _oneCodeView;
}
- (UITextView *)textview
{
    if (!_textview) {
        _textview = [UITextView new];
        _textview.keyboardType = UIKeyboardTypeNumberPad;
        _textview.delegate = self;
    }
    return _textview;
}


@end

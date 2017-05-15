//
//  SearchTableViewCell.m
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = KCOLOR_WHITE;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(10, 0, 80, 50)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KTHEME_COLOR
                                           font:KICON_FONT_(10)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    _titleLabel.numberOfLines= 3;
    
    _textField = [UITextField createTextFieldWithFrame:CGRectMake(_titleLabel.right+10, 0, SCREEN_WIDTH-_titleLabel.right-KMARGIN_15, 50)
                                       backgroundColor:KCOLOR_Clear
                                           borderStyle:UITextBorderStyleNone
                                           placeholder:@""
                                                  text:@""
                                             textColor:KCOLOR_Black_343434
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentLeft];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    
    _codeBtn = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH-KMARGIN_15-75, 10, 75, 30)
                               backgroundColor:KTHEME_COLOR
                                    titleColor:KCOLOR_WHITE
                                          font:KICON_FONT_(12)
                                         title:@"Get code"
                                 conrnerRadius:KCORNER_RADIUS_3
                                   borderWidth:0
                                   borderColor:nil];
    _codeBtn.hidden = YES;
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_textField];
    [self.contentView addSubview:_codeBtn];
    
    return self;
}



- (void)showText:(NSIndexPath *)indexP
            type:(NSString *)type
      dictionary:(NSDictionary *)dict

{
    self.textField.userInteractionEnabled = YES;
    if ([type isEqualToString:@"居民意见"]) {
        _codeBtn.hidden = YES;
        switch (indexP.row) {
            case 0:
            {
                self.titleLabel.text = @"姓    名";
                self.textField.placeholder = @"请输入姓名";
                self.textField.keyboardType = UIKeyboardTypeDefault;
                self.textField.text = dict[@"name"];
            }
                break;
                
            case 1:
            {
            }
                break;
                
            case 2:
            {
                self.titleLabel.text = @"手机号";
                self.textField.placeholder = @"请输入手机号码";
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.text = dict[@"mobile"];
            }
                break;
                
            case 3:
            {
                _codeBtn.hidden = NO;
                self.titleLabel.text = @"验证码";
                self.textField.placeholder = @"获取验证码";
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.text = dict[@"opinion_code_verify"];
            }
                break;
                
            default:
                break;
        }
    }
    else if ([type isEqualToString:@"办事指南"])
    {
        self.textField.userInteractionEnabled = NO;
        
        switch (indexP.row) {
            case 0:
            {
                self.titleLabel.text = @"主题";
                self.textField.placeholder = @"请选择需办事主题";
                self.textField.text = dict[@"title"];
            }
                break;
                
            case 1:
            {
                self.titleLabel.text = @"部门";
                self.textField.placeholder = @"请选择需办事的部门";
                self.textField.text = dict[@"department"];
            }
                break;
                
            default:
                break;
        }
    }
    else if ([type isEqualToString:@"党员报备"])
    {
        switch (indexP.section) {
            case 0:
            {
                switch (indexP.row) {
                    case 0:
                    {
                        self.textField.tag = 100;
                        self.titleLabel.text = @"姓名";
                        self.textField.placeholder = @"请输入姓名";
                        self.textField.keyboardType = UIKeyboardTypeDefault;
                        self.textField.text = dict[@"name"];
                    }
                        break;
                        
                    case 1:
                    {
                        self.textField.userInteractionEnabled = NO;
                        
                        self.titleLabel.text = @"性别";
                        self.textField.placeholder = @"请选择性别";
                        if ([dict[@"sex"] length]>0) {
                            if ([dict[@"sex"] isEqualToString:@"1"]) {
                                self.textField.text = @"男";
                            }
                            else
                            {
                                self.textField.text = @"女";
                            }
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        self.textField.tag = 200;
                        self.titleLabel.text = @"民族";
                        self.textField.placeholder = @"请输入民族";
                        self.textField.keyboardType = UIKeyboardTypeDefault;
                        self.textField.text = dict[@"nation"];
                    }
                        break;
                        
                    case 3:
                    {
                        self.textField.userInteractionEnabled = NO;
                        
                        self.titleLabel.text = @"入党时间";
                        self.textField.placeholder = @"请选择入党时间";
                        if ([dict[@"time"] length]>0) {
                            self.textField.text = [PublicMethod getYMDUsingCreatedTimestamp:dict[@"time"]];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 1:
            {
                switch (indexP.row) {
                    case 0:
                    {
                        self.textField.tag = 300;
                        self.titleLabel.text = @"身份证";
                        self.textField.placeholder = @"请输入身份证号码";
                        self.textField.keyboardType = UIKeyboardTypeDefault;
                        self.textField.text = dict[@"identity"];
                    }
                        break;
                        
                    case 1:
                    {
                        self.textField.tag = 400;
                        
                        self.titleLabel.text = @"家庭地址";
                        self.textField.placeholder = @"请输入家庭地址";
                        self.textField.text = dict[@"address"];
                        self.textField.keyboardType = UIKeyboardTypeDefault;
                    }
                        break;
                        
                    case 2:
                    {
                        self.textField.tag = 500;
                        self.titleLabel.text = @"联系方式";
                        self.textField.placeholder = @"请输入电话号码";
                        self.textField.keyboardType = UIKeyboardTypeNumberPad;
                        self.textField.text = dict[@"mobile"];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
    }
    else if ([type isEqualToString:@"充值卡充值"])
    {
        _codeBtn.hidden = YES;
        switch (indexP.section) {
            case 0:
            {
                self.titleLabel.text = @"卡号";
                self.textField.placeholder = @"请输入充值卡卡号";
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.text = dict[@"number"];
            }
                break;
                
            case 1:
            {
                self.titleLabel.text = @"密码";
                self.textField.placeholder = @"请输入充值卡密码";
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.secureTextEntry = YES;
                self.textField.text = dict[@"password"];
            }
                break;
                
            case 2:
            {
                _codeBtn.hidden = NO;
                self.titleLabel.text = @"验证码";
                self.textField.placeholder = @"请输入验证码";
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.text = dict[@"code_verify"];
            }
                break;
                
            default:
                break;
        }
    }
}






@end

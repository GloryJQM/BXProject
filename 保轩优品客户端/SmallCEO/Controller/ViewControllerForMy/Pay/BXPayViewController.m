//
//  PayViewController.m
//  SmallCEO
//
//  Created by peterwang on 17/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BxPayViewController.h"
#import "BxPayResultViewController.h"
@interface BXPayViewController(){
    UIButton *selectButton;
    UITextField *_textField;
    UIButton *_payButton;
    
    UIView *_secondView;
    
    UILabel *_discounts;
    UILabel *_pocket;
    
    CGFloat _countdown;
    
    UILabel *_hintLabel;
}

@end

@implementation BXPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = backWhite;
    self.title = [NSString stringWithFormat:@"%@", self.dataDic[@"shop_name"]];
    [self creationView];
    
}

- (void)creationView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, UI_SCREEN_WIDTH - 30, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 2;
    backView.layer.masksToBounds = YES;
    backView.layer.borderColor = ColorE4E4E4.CGColor;
    backView.layer.borderWidth = 0.5;
    [self.view addSubview:backView];
    
    UILabel *sumPrice = [[UILabel alloc] initWithFrame:CGRectMake(12, 19, 100, 17)];
    sumPrice.font = [UIFont systemFontOfSize:14];
    sumPrice.textColor = Color161616;
    sumPrice.textAlignment = NSTextAlignmentRight;
    sumPrice.text = @"消费总额 (元)";
    
    CGSize sumSize = [sumPrice sizeThatFits:CGSizeMake(100, 17)];
    sumPrice.frame= CGRectMake(12, 19, sumSize.width, 17);
    
    [backView addSubview:sumPrice];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(sumPrice.maxX + 12, sumPrice.minY, backView.width - sumPrice.maxX - 24, sumPrice.height)];
    _textField.placeholder = @"请询问服务人员后输入";
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.textColor = Color161616;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.font = [UIFont boldSystemFontOfSize:14];
    [_textField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:_textField];
    
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
    btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
    [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
    btnT.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    _textField.inputAccessoryView=btnT;
    
    selectButton = [[UIButton alloc] initWithFrame:CGRectMake(15, backView.maxY + 12, 140, 20)];
    [selectButton setImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"button-xuanzhong@2x"] forState:UIControlStateSelected];
    [selectButton setTitle:@"  使用代金券抵扣金额" forState:UIControlStateNormal];
    selectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [selectButton setTitleColor:Color74828B forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    
//    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectButton.maxX + 6, selectButton.minY, UI_SCREEN_WIDTH - selectButton.maxX - 30, 15)];
//    hintLabel.text = @"使用代金券抵扣金额";
//    hintLabel.textColor = Color74828B;
//    hintLabel.font = [UIFont systemFontOfSize:12];
//    hintLabel.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:hintLabel];
    
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(15, selectButton.maxY + 12, UI_SCREEN_WIDTH - 30, 100)];
    [self.view addSubview:_secondView];
    
    [_secondView addLineWithY:0 X:0 width: _secondView.width];
    
    
    UILabel *voucherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, _secondView.width, 20)];
    voucherLabel.text = @"代金券抵扣";
    voucherLabel.textColor = Color161616;
    voucherLabel.font = [UIFont systemFontOfSize:14];
    voucherLabel.textAlignment = NSTextAlignmentLeft;
    [_secondView addSubview:voucherLabel];
    
    UILabel *discountsPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, voucherLabel.maxY + 4, 100, 17)];
    discountsPrice.text = @"优惠金额";
    discountsPrice.textColor = App_Main_Color;
    discountsPrice.font = [UIFont systemFontOfSize:12];
    discountsPrice.textAlignment = NSTextAlignmentLeft;
    [_secondView addSubview:discountsPrice];
    
    _discounts = [[UILabel alloc] initWithFrame:CGRectMake(discountsPrice.maxX + 10, discountsPrice.minY,  _secondView.width - discountsPrice.maxX - 10, 17)];
    _discounts.text = @"0.00";
    _discounts.textColor = App_Main_Color;
    _discounts.font = [UIFont systemFontOfSize:12];
    _discounts.textAlignment = NSTextAlignmentRight;
    [_secondView addSubview:_discounts];
    
    [_secondView addLineWithY:_discounts.maxY + 15 X:0 width:  _secondView.width];
    
    UILabel *pocketPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, _discounts.maxY + 30, 100, 17)];
    pocketPrice.text = @"实付金额 (元)";
    pocketPrice.textColor = Color161616;
    pocketPrice.font = [UIFont systemFontOfSize:14];
    pocketPrice.textAlignment = NSTextAlignmentLeft;
    [_secondView addSubview:pocketPrice];
    
    _pocket = [[UILabel alloc] initWithFrame:CGRectMake(pocketPrice.maxX + 10, pocketPrice.minY,  _secondView.width - pocketPrice.maxX - 10, 17)];
    _pocket.text = @"0.00";
    _pocket.textColor = App_Main_Color;
    _pocket.font = [UIFont boldSystemFontOfSize:18];
    _pocket.textAlignment = NSTextAlignmentRight;
    [_secondView addSubview:_pocket];
    
    _secondView.hidden = YES;
    
    _payButton = [[UIButton alloc] initWithFrame:CGRectMake(15, selectButton.maxY + 30, UI_SCREEN_WIDTH - 30, 55)];
    [_payButton setTitle:@"立即买单" forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _payButton.backgroundColor = ColorB0B8BA;
    _payButton.layer.cornerRadius = 2;
    _payButton.layer.masksToBounds = YES;
    _payButton.userInteractionEnabled = NO;
    [_payButton addTarget:self action:@selector(clickPayButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payButton];
    
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(_payButton.x, _payButton.maxY + 10, UI_SCREEN_WIDTH - _payButton.x * 2, 20)];
    _hintLabel.textColor = ColorB0B8BA;
    _hintLabel.font = [UIFont systemFontOfSize:14];
    _hintLabel.textAlignment = NSTextAlignmentLeft;
    _hintLabel.text = @"使用代金券抵扣将无法用金币支付";
    _hintLabel.hidden = YES;
    [self.view addSubview:_hintLabel];
}

- (void)clickPayButton {
    BxPayResultViewController *vc = [[BxPayResultViewController alloc] init];
    if (selectButton.selected && _countdown > 0) {
        vc.isVoucher = YES;
        vc.use_coupon_number = [NSString stringWithFormat:@"%f", _countdown];
    }else {
        vc.use_coupon_number = @"0";
    }
    vc.total_money = _textField.text;
    vc.i_uid = [NSString stringWithFormat:@"%@", self.dataDic[@"i_uid"]];
    vc.total_money_coupon = [NSString stringWithFormat:@"%.2f",[_textField.text floatValue]-_countdown];
    vc.payment_mode = self.dataDic[@"payment_mode"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _secondView.hidden = NO;
        _payButton.frame = CGRectMake(15, _secondView.maxY + 30, UI_SCREEN_WIDTH - 30, 55);
        _hintLabel.hidden = NO;
    }else {
        _secondView.hidden = YES;
        _payButton.frame = CGRectMake(15, selectButton.maxY + 30, UI_SCREEN_WIDTH - 30, 55);
        _hintLabel.hidden = YES;
    }
    
    _hintLabel.frame = CGRectMake(_payButton.x, _payButton.maxY + 10, UI_SCREEN_WIDTH - _payButton.x * 2, 20);
    
}

- (void)textField:(UITextField *)textField {
    /*正常金额验证避免多个. */
    NSString *str = textField.text;
    NSInteger d = 0;//作为多个.的标识
    if ([textField.text isEqualToString:@"."]) {
        textField.text = @"0.";
    }
    for(int i =0; i < str.length; i++) {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"."]) {
            d++;
        }
    }
    if (str.length>1) {
        if ([[str substringFromIndex:str.length-1] isEqualToString:@"."]&&d > 1) {
            textField.text = [str substringToIndex:str.length - 1];
        }
    }
    
    if (textField.text.length > 0 && [textField.text floatValue] > 0) {
        textField.font = [UIFont boldSystemFontOfSize:16];
        _payButton.backgroundColor = App_Main_Color;
        _payButton.userInteractionEnabled = YES;
    }else {
        textField.font = [UIFont boldSystemFontOfSize:14];
        _payButton.backgroundColor = ColorB0B8BA;
        _payButton.userInteractionEnabled = NO;
    }
    
    //开始计算可用的代金券
    CGFloat scale = [_dataDic[@"coupon_info"][@"able_use_coupon_scale"] doubleValue];
    CGFloat ableuse = scale*[textField.text doubleValue];
    CGFloat ablecoupon = [_dataDic[@"coupon_info"][@"able_use_coupon_number"] doubleValue];
    
    if (ableuse > ablecoupon) {
        _countdown = ablecoupon;
    }else {
        _countdown = ableuse;
    }
    
    NSString *discounts = [NSString stringWithFormat:@"%.2f",floor(_countdown*100)/100];
    _discounts.text = [NSString stringWithFormat:@"-%@", [discounts money1]];
    
    NSString *pocket = [NSString stringWithFormat:@"%.2f",[textField.text doubleValue]-_countdown];
    _pocket.text = [pocket money1];
    
}

#pragma  mark  收起键盘
-(void)missKeyBoard {
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

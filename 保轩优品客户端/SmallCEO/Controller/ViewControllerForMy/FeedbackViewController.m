#import "FeedbackViewController.h"

#import "CustomTextView.h"

@interface FeedbackViewController ()

@property (nonatomic, strong) CustomTextView *textView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation FeedbackViewController

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    self.title = @"意见反馈";
    self.view.backgroundColor = BACK_COLOR;
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitButton];
}

#pragma mark - UIButton action method
- (void)submitContents {
    NSString *string = self.textView.text;
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (string.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入意见内容"];
        return;
    }
    
    [self requestSendFeedbackContents];
}
   #pragma mark - 网络请求方法
- (void)requestSendFeedbackContents{
    [SVProgressHUD show];
    NSString*body = [NSString stringWithFormat:@"act=1&feedback=%@",_textView.text];
    NSString *str=MOBILE_SERVER_URL(@"feedbackApi.php");
    
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject){
                               DLog(@"%@",responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"info"]];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }else {
                                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"info"]];
                               }
                               
                           }failureBlock:^(AFHTTPRequestOperation *operation, NSError *error){
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark - Button
- (UIButton *)submitButton
{
    if (!_submitButton)
    {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _submitButton.backgroundColor = App_Main_Color;
        _submitButton.layer.cornerRadius = 3;
        [_submitButton addTarget:self action:@selector(submitContents) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.frame = CGRectMake(15, self.textView.maxY + 25, UI_SCREEN_WIDTH - 30, 40);
    }
    
    return _submitButton;
}

- (CustomTextView *)textView
{
    if (!_textView)
    {
        _textView = [[CustomTextView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
        _textView.backgroundColor = WHITE_COLOR;
        _textView.placeholder = @"在此输入您的建议或意见，我们将尽快改进，只为更好的为您服务";
        _textView.textContainerInset = UIEdgeInsetsMake(8, 10, 0, 0);
        _textView.font = [UIFont systemFontOfSize:14.0];
    }
    
    return _textView;
}

@end

//
//  ViewController.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "ViewController.h"
#import "CLMessageFrame.h"
#import "CLMessage.h"
#import "CLMessageCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/250 blue:236.0/250 alpha:1];
    //不被选中
    self.tableView.allowsSelection = NO;
    //设置键盘弹出的监听
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardWillChangerFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
 
}
//键盘弹出改变Frame的监听将调用的方法
- (void)keyBoardWillChangerFrame:(NSNotification *)noteInfo {
    //NSLog(@"%@",noteInfo.userInfo);
    /**
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 0}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 667}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 667}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 0}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 0}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     */
    CGRect rectEnd =  [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardY = rectEnd.origin.y;
    CGFloat transformY = keyBoardY - self.view.frame.size.height;
    self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    
    
    //键盘弹出 UITableView滚到最下面
    NSIndexPath *lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mak -UITableViewDataSource 方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    CLMessageCell *cell = [CLMessageCell messageCellWithTableView:tableView];
    cell.messageFrame = messageFrame;
    return cell;
}

#pragma mak -UITableViewDelegate 方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //键盘叫回去
    [self.view endEditing:YES];
}


#pragma mak -UITextFieldDelegate 方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //获取输入框的信息
    NSString *inputMessage = textField.text;
    
    [self sendMessage:inputMessage WithType:CLMessageTypeMe];
    
    [self sendMessage:@"gun!" WithType:CLMessageTypeOther];
    
    textField.text = nil;
    
    return YES;
}
- (void)sendMessage:(NSString *)meg WithType:(CLMessageType)type {
    //去增加一条消息模型
    CLMessage *message = [[CLMessage alloc] init];
    message.text = meg;
    //获取系统当前时间
    NSDate *nowDate = [NSDate date];
    //去创建一个日期格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"今天 HH:mm";
    message.time =[formatter stringFromDate:nowDate];
    message.type = type;
    
    //与上一个模型的时间比较，相同隐藏
    //获取上一个模型
    CLMessageFrame *lastMessageFrame = [self.messageFrames lastObject];
    if ([message.time isEqualToString:lastMessageFrame.message.time]) {
        message.hideTime = YES;
    }
    CLMessageFrame *messageFrame = [[CLMessageFrame alloc] init];
    messageFrame.message = message;
    
    [self.messageFrames addObject:messageFrame];
    //刷新页面
    [self.tableView reloadData];
    
    //tableView移到最下面
    NSIndexPath *lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


#pragma mak -懒加载
//懒加载
- (NSMutableArray *)messageFrames {
    if(_messageFrames == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayMessages = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            CLMessage *model = [CLMessage messageWithDict:dict];
            
            //获取上一个模型
            CLMessage *preMessage = (CLMessage *)[[arrayMessages lastObject] message];
            //判断CLMessage中time属性的值 是否 和上一个CLMessage的time值一样 若一样设置一个标识
            if([model.time isEqualToString:preMessage.time]){
                model.hideTime = YES;
            }
            CLMessageFrame *messageFrame = [[CLMessageFrame alloc] init];
            messageFrame.message = model;
            
            
            [arrayMessages addObject:messageFrame];
        }
    _messageFrames = arrayMessages;
    }
    return _messageFrames;
}

@end

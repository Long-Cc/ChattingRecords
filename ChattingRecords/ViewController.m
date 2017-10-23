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

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
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

#pragma mak -懒加载
//懒加载
- (NSMutableArray *)messageFrames {
    if(_messageFrames == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayMessages = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            CLMessage *model = [CLMessage messageWithDict:dict];
            CLMessageFrame *messageFrame = [[CLMessageFrame alloc] init];
            messageFrame.message = model;
            [arrayMessages addObject:messageFrame];
        }
    _messageFrames = arrayMessages;
    }
    return _messageFrames;
}

@end

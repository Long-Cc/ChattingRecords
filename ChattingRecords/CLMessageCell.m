//
//  CLMessageCell.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "CLMessageCell.h"
#import "CLMessage.h"
#import "CLMessageFrame.h"
@interface CLMessageCell()
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UIButton *textButton;
@end

@implementation CLMessageCell
#pragma mark -重写messageFrame的setter方法
- (void)setMessageFrame:(CLMessageFrame *)messageFrame {
    //获取数据模型
    CLMessage *message = messageFrame.message;
    _messageFrame = messageFrame;
//分别设每个子控件的数据和Frame;
    //设置时间Label的 数据 和 Frame
    self.timeLabel.text = message.time;
    self.timeLabel.frame = messageFrame.timeFrame;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.hidden = message.hideTime;
    
    //设置正文Button的 数据 和 Frame
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
    self.textButton.frame = messageFrame.textFrame;
    //设置正文颜色
    if(message.type == CLMessageTypeMe) {
         [self.textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
         [self.textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    //设置正文数字大小
    self.textButton.titleLabel.font = textFont;
    //设置正文可以换行
    self.textButton.titleLabel.numberOfLines = 0;
    //[self.textButton setBackgroundColor:[UIColor yellowColor]];
    self.textButton.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    
    //设置正文内容的背景图
    NSString *imageName;
    if(message.type == CLMessageTypeMe) {
        imageName = @"chat_right";
    }else {
        imageName = @"chat_left";
    }
    UIImage *backgroundImage = [UIImage imageNamed:imageName];
    //图片使用拉伸方式为平铺形式 不使图片变形
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width * 0.5 topCapHeight:backgroundImage.size.height * 0.5];
    [self.textButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self.textButton setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
    
    //设置头像ImageView的 数据 和 Frame
    NSString *iconName = message.type == 0 ? @"me":@"Other";
    self.iconImage.image = [UIImage imageNamed:iconName];
    self.iconImage.frame = messageFrame.iconFrame;
    
}

#pragma mark -重写initWithStyle
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //创建时间的UILabel
        UILabel *timeLlabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLlabel];
        self.timeLabel = timeLlabel;
        
        //创建正文消息的UIButton
        UIButton *textBtn = [[UIButton alloc] init];
        [self.contentView addSubview:textBtn];
        self.textButton = textBtn;
        
        //创建头像的UIImage
        UIImageView *iconImg = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImg];
        self.iconImage = iconImg;
        
    }
    return self;
}



+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message_cell";
    CLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[CLMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SXGCodeButton.h
//  ABCApp
//
//  Created by Boris on 2024/1/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXGCodeButton : UIButton
/**
 构造方法
 
 @param duration 倒计时时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithDuration:(NSInteger)duration
                   buttonClicked:(void(^)())buttonClicked
                  countDownStart:(void(^)())countDownStart
               countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
             countDownCompletion:(void(^)())countDownCompletion;

/** 开始倒计时 */
- (void)startCountDown;

/** 结束倒计时 */
- (void)endCountDown;
@end

NS_ASSUME_NONNULL_END

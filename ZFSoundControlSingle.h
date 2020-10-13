//
//  ZFSoundControlSingle.h
//  TuiTuiYYC
//
//  Created by ZhiF_Zhu on 2020/7/3.
//  Copyright © 2020 朱洁珊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>//引入头框架的文件

NS_ASSUME_NONNULL_BEGIN

@interface ZFSoundControlSingle : NSObject

@property(nonatomic,assign)SystemSoundID soundID;//播放文件标识
//获取震动、声音、自定义声音对象的方法
+ (id) sharedInstanceForVibrate;
+ (id) sharedInstanceForSound;
+ (id) sharedInstanceForProjectSound;
/**
 *  @brief  为播放震动效果初始化
 *  @return self
*/
 -(id)initForPlayingVibrate;
/**
 *  @brief  为播放系统音效初始化(无需提供音频文件)
 *  @param resourceName 系统音效名称
 *  @param type 系统音效类型
 *  @return self
*/
 -(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;
/**
 *  @brief  为播放特定的音频文件初始化（需提供音频文件）
 *  @param filename 音频文件名（加在工程中）
 *  @return self
 */
-(id)initForPlayingSoundEffectWith:(NSString *)filename;
//播放声音或者震动
-(void)play;
//播放提醒
-(void)playRemind;

//取消声音
-(void)cancleSound;
//取消自定义声音,单例对象置为空
-(void)cancleProjectSound;
//取消振动,单例对象置为空
-(void)cancleVibrate;

@end

NS_ASSUME_NONNULL_END

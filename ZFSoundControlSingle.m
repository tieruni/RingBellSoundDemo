//
//  ZFSoundControlSingle.m
//  TuiTuiYYC
//
//  Created by ZhiF_Zhu on 2020/7/3.
//  Copyright © 2020 朱洁珊. All rights reserved.
//

#import "ZFSoundControlSingle.h"

@implementation ZFSoundControlSingle
static ZFSoundControlSingle *_sharedInstance;//震动对象全局变量
static ZFSoundControlSingle *_sharedInstanceForSound;//声音对象全局变量
static ZFSoundControlSingle *_sharedInstanceForProjectSound;//自定义声音对象全局变量
#pragma mark -- 实现获取各对象的方法
//获取震动对象
+(id)sharedInstanceForVibrate
{
    @synchronized ([ZFSoundControlSingle class]) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[ZFSoundControlSingle alloc] initForPlayingVibrate];
        }
    }
    return _sharedInstance;
}
//获取声音
+ (id)sharedInstanceForSound
{
    @synchronized ([ZFSoundControlSingle class]) {
        if (_sharedInstanceForSound == nil) {
            _sharedInstanceForSound = [[ZFSoundControlSingle alloc] initForPlayingSystemSoundEffectWith:@"sms-received2" ofType:@"caf"];
        }
    }
    return _sharedInstanceForSound;
}
//播放自定义声音
+ (id)sharedInstanceForProjectSound{
    @synchronized ([ZFSoundControlSingle class]) {
        if (_sharedInstanceForProjectSound == nil) {
            _sharedInstanceForProjectSound = [[ZFSoundControlSingle alloc] initForPlayingSoundEffectWith:@"unbelievable.caf"];
        }
    }
    return _sharedInstanceForProjectSound;
}
#pragma mark -- 各对象的初始化方法
-(id)initForPlayingVibrate {
     self = [super init];
     if (self) {
         _soundID = kSystemSoundID_Vibrate;//震动方式
     }
     return self;
}
/*
 初始化声音对象的方法
 第一个参数：音频文件的名字   第二个参数：音频文件的后缀名字
 */
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type{
    self=[super init];
    if(self){
        //获取到系统文件中的声音
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",resourceName,type];
        if(path){//目标文件存在
            //创建声音对象
            SystemSoundID theSoundID;
            OSStatus error =AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&theSoundID);
            if(error == kAudioServicesNoError){//创建成功
                _soundID=theSoundID;
            }else{
                NSLog(@"Failed to create sound");
            }
        }
    }
    return  self;
}
//初始化声音对象--传入的参数为声音文件的路径
-(id)initForPlayingSoundEffectWith:(NSString *)filename {
     self = [super init];
     if (self) {
         NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
         if (fileURL != nil){
             SystemSoundID theSoundID;
             OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
             if (error == kAudioServicesNoError){//创建成功
                 _soundID = theSoundID;
             }else {
                 NSLog(@"Failed to create sound ");
             }
         }
     }
     return self;
}
//播放系统声音或震动(振动的soundID是系统的枚举值)
-(void)play {
     AudioServicesPlaySystemSound(_soundID);//播放音乐
}

//播放提醒
-(void)playRemind{
    AudioServicesPlayAlertSound(_soundID);//提醒功能
}

//取消声音,单例对象置为空
-(void)cancleSound
{
    _sharedInstanceForSound = nil;
}

//取消自定义声音,单例对象置为空
-(void)cancleProjectSound
{
    _sharedInstanceForProjectSound = nil;
}

//取消振动,单例对象置为空
-(void)cancleVibrate
{
    _sharedInstance = nil;
}

//释放声音对象
-(void)dealloc{
    AudioServicesDisposeSystemSoundID(_soundID);
}

@end

//
//  MenuSceneController.h
//  Raiders
//
//  Created by James Sugrue on 26/05/11.
//  Copyright 2011 SoftwareX. All rights reserved.
//
#import "AbstractSceneController.h"
#import <AVFoundation/AVFoundation.h>

@class Sprite;

@interface MainSceneController : AbstractSceneController<AVAudioPlayerDelegate> {
    AVAudioPlayer *audioPlayer;
    CGPoint point;
    int explosion; // 0 is origin, 1-20 is exploding, 20-40 is hidden
    float speed;
    float windspeed;
    int windcount;
}

float _random(int,int);

@property (nonatomic, retain) Sprite *balloon;
@property (nonatomic, retain) Sprite *balloon_ex;
@property (nonatomic, retain) Sprite *foreground;

@end

//
//  MenuSceneController.m
//  Raiders
//
//  Created by James Sugrue on 26/05/11.
//  Copyright 2011 SoftwareX. All rights reserved.
//

#import "MainSceneController.h"
#import "Sprite.h"
#import "GameController.h"

@implementation MainSceneController

@synthesize balloon;
@synthesize balloon_ex;
@synthesize foreground;

float _random(int min, int max){
    int r = random() % (max - min + 1) * 100 + min * 100;
    return (float) r / 100.0f;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		balloon = [[Sprite alloc] initWithImageNamed:@"balloon"];
        balloon_ex = [[Sprite alloc] initWithImageNamed:@"balloon_ex"];
        foreground = [[Sprite alloc] initWithImageNamed:@"foreground"];
        [self addSprite:balloon];
        [self addSprite:balloon_ex];
        [self addSprite:foreground];
        point = CGPointMake(_random(0,(320 - 100)), 480.0f);
        speed = _random(2, 5);
        windspeed = 0.0f;
        windcount = 0;
        explosion = 0;
        // 背景色
        glClearColor(0.4f, 0.8f, 1.0f, 1.0f);
        // 効果音
        NSURL *url = [[NSBundle mainBundle] URLForResource: @"se_maoudamashii_system23"
                                             withExtension: @"wav"];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [audioPlayer setDelegate:self];
	}
	return self;
}

- (void)playScene {
    glClear(GL_COLOR_BUFFER_BIT);
    
    const CGPoint hidden = CGPointMake(320.0f, 480.0f);
    
    if (explosion == 0){
        [balloon drawAtPosition:point];
        [balloon_ex drawAtPosition:hidden];
        point.y -= speed ;
        if (point.y < 0 - 200) {
            // 画面から消えたら割ってしまう
            explosion = 1;
        }
        if (windcount > (int)_random(10,50)){
            windspeed = _random(-1, 1);
            windcount = 0;
        }else{
            windcount++;
        }
        point.x += windspeed;
        if (point.x < 0) point.x = 0;
        else if (point.x > 320 - 100) point.x = 320 - 100;
        
    }else if(explosion < 20){
        [balloon drawAtPosition:hidden];
        [balloon_ex drawAtPosition:point];
        explosion++;
    }else if(explosion < 40){
        [balloon drawAtPosition:hidden];
        [balloon_ex drawAtPosition:hidden];
        explosion++;
    }else{
        // explosion is over 40.
        [balloon drawAtPosition:hidden];
        [balloon_ex drawAtPosition:hidden];
        explosion = 0;
        point.y = 480.0f;
        point.x = _random(0,320 - 100);
        speed = _random(2, 5);
    }
    
    [foreground drawAtPosition:CGPointMake(0.0f, 0.0f)];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    CGPoint p = [[touches anyObject] locationInView:aView];

    int w = 100, h = 100;
    if (p.x > point.x && p.x < point.x + w
        && p.y > point.y && p.y < point.y + h && explosion == 0) {
        explosion = 1;
        [audioPlayer play];
    }
    
}

@end

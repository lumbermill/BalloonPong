//
//  ViewController.m
//  BalloonPong
//
//  Created by Itou Yousei on 11/13/13.
//  Copyright (c) 2013 LumberMill, Inc. All rights reserved.
//

#import "ViewController.h"
#import "AbstractSceneController.h"
#import "GameController.h"

@interface ViewController ()

@property (strong, nonatomic) EAGLContext *context;
- (void)setupGL;
- (void)tearDownGL;

@end

@implementation ViewController{
    GameController *sharedGameController;
    AVAudioPlayer *audioPlayer;
}

@synthesize context = _context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self setupGL];
    sharedGameController = [GameController sharedGameController];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource: @"game_maoudamashii_5_casino04"
                                         withExtension: @"wav"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.volume = 0.4;
    [audioPlayer setDelegate:self];
    [audioPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    [sharedGameController updateWorld];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [sharedGameController playCurrentScene];
    
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	// Pass touch events onto the current scene
	// [cs touchesEnded:touches withEvent:event view:self.view];
    
    AbstractSceneController *cs = [sharedGameController currentScene];
    [cs touchesEnded:touches withEvent: event view:self.view];
}


@end

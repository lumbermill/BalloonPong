//
//  GameController.h
//  Raiders
//
//  Created by James Sugrue on 26/05/11.
//  Copyright 2011 SoftwareX. All rights reserved.
//

@class AbstractSceneController;

@interface GameController : NSObject {

}

@property (nonatomic, retain) AbstractSceneController *currentScene;

+ (GameController *)sharedGameController;

- (void)playCurrentScene;
- (void)updateWorld;

@end

//
//  UtilClass.h
//  pocketToons
//
//  Created by Yaniv Steiner on 6/23/14.
//  Copyright (c) 2014 goodappl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <AudioToolbox/AudioToolbox.h>

@interface UtilClass : NSObject <UIActionSheetDelegate>

{
     MFMailComposeViewController *pickerMail;
    //SystemSoundID audioEffect;
}



+ (id)sharedManager ;
-(void)fireAlert :(NSString *)titleSTR :(NSString *)messageSTR;
-(void)firePopup:(NSString *)msg : (NSString *)typeSTR;
//
- (CAAnimation*)getShakeAnimation;
- (CAAnimation*)getBeatAnimation;
//
- (void)playAudio;
@end

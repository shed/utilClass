//
//  UtilClass.m
//  pocketToons
//
//  Created by Yaniv Steiner on 6/23/14.
//  Copyright (c) 2014 goodappl. All rights reserved.
//

#import "UtilClass.h"
#import "AppDelegate.h"


@implementation UtilClass



#pragma mark ----

+ (id)sharedManager {
    static UtilClass *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //
    }
    return self;
}





-(IBAction)userComment:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Feedback", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:
                            NSLocalizedString(@"I like it!", nil),
                            
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}





- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //NSString *str = [NSString stringWithFormat:@"%li",(long)popup.tag];
    //NSString *strClean = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[tracker set:kGAIScreenName value:str];
    //[tracker send:[[GAIDictionaryBuilder createAppView] build]];
    //
    // [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"APP"     // Event category (required)
    //                                                     action:@"share type"  // Event action (required)
    //                                                     label:strClean           // Event label
    //                                                      value:nil] build]];
    
    
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self openiTuneReview];
                    break;
                    
                default:
                    break;
                    
            }
        }
    }
}



#pragma mark mailit




-(void)fireAlert :(NSString *)titleSTR :(NSString *)messageSTR
{
    
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:titleSTR
                                          message:messageSTR
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", nil)
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       // No actions
                                   }];
    [alertController addAction:cancelAction];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alertController animated:NO completion:nil];
    
    
    
}


-(void)firePopup:(NSString *)msg : (NSString *)typeSTR
{
    
    UIView *viewPopup=[[UIView alloc]init];
    [viewPopup setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.99]];
    if ([typeSTR isEqualToString:@"searchFound"]) {
        [viewPopup setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.99]];
    }
    if ([typeSTR isEqualToString:@"searchNotFound"]) {
        [viewPopup setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.99]];
    }
    if ([typeSTR isEqualToString:@"error"]) {
        [viewPopup setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.99]];
    }
    if ([typeSTR isEqualToString:@"alert"]) {
        [viewPopup setBackgroundColor:[UIColorFromRGB(0x000000) colorWithAlphaComponent:0.99]];
    }
    
    
    
    viewPopup.alpha=1.0f;
    
    
    
    
    // add into window
    AppDelegate *appdelgateobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIView *appVC =  appdelgateobj.window;
    
    viewPopup.frame =CGRectMake(0.0, 0.0, appVC.bounds.size.width * 1.0, 44.0);
    //viewPopup.center = appVC.center;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:viewPopup.bounds];
    lbl.textColor = [UIColor whiteColor] ;
    //lbl.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.7];
    lbl.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:20.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    lbl.text= msg;
    [viewPopup addSubview:lbl];
    //lbl.center = viewPopup.center;
    
    
    [viewPopup setFrame:CGRectMake(0.0, -100, viewPopup.bounds.size.width, viewPopup.bounds.size.height)];
    [appdelgateobj.window addSubview:viewPopup];
    [appdelgateobj.window bringSubviewToFront:viewPopup];
    
    
    
    
    
    
    [UIView animateWithDuration:0.6
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [viewPopup setFrame:CGRectMake(0.0, 0.0, viewPopup.bounds.size.width, viewPopup.bounds.size.height)];
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.9
                                               delay:3.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              // Grow!
                                              viewPopup.alpha = 0.0;
                                              [viewPopup setFrame:CGRectMake(0.0, 0.0, viewPopup.bounds.size.width, viewPopup.bounds.size.height*-1)];
                                              
                                          }
                                          completion:^(BOOL finished){
                                              [viewPopup removeFromSuperview];
                                          }];
                     }];
    
    
    
    
    
    
    
}


- (CAAnimation*)getShakeAnimation
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.06f;
    
    NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.06;
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}

- (CAAnimation*)getBeatAnimation
{
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=0.5;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.5];
    //[theLayer addAnimation:theAnimation forKey:@"animateOpacity"]; //myButton.layer instead of
    return theAnimation;
}










-(void)flipSingleView:(UIView *)theView
{
    
    [UIView beginAnimations:@"Flip" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:theView cache:YES];
    [UIView commitAnimations];

}














#pragma mark -

- (void)playAudio {
    [self playSound:@"coin" :@"wav"];
}

- (void)playSound :(NSString *)fName :(NSString *) ext{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}


-(void)openiTuneReview
{
    //NSString *appId = @"406165193";
    NSString *link = @"itms-apps://itunes.apple.com/app/id406165193";
    DLog(@"%@",link);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:link]];
}


@end

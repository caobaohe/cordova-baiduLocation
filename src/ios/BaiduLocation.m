//
//  BaiduLocation.m
//
//  Created by Jonah on 16-04-03.
//
//

#import "BaiduLocation.h"
@implementation BaiduLocation

static BMKMapManager* _mapManager;
static BMKLocationService* _locService;
NSString* _callbackId;
- (void)pluginInitialize {
    //NSLog(@"### BaiduLocation pluginInitialize ");
    
    if(nil == _mapManager)
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BaiduSDKParams" ofType:@"plist"];
        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        data=[data objectForKey:@"params"];
        NSString *baiduSdk_appid=[data objectForKey:@"API_KEY"];
        // 要使用百度地图，请先启动BaiduMapManager
        _mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [_mapManager start:baiduSdk_appid generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
        
        if ( nil == _locService )
        {
            _locService = [[BMKLocationService alloc]init];
        }
    }
}
//- (void)pluginInitialize
//{

//}

-(void)startLocationService:(CDVInvokedUrlCommand*)command
{

}
-(void)stopLocationService:(CDVInvokedUrlCommand*)command
{

}
-(void)getCurrentPosition:(CDVInvokedUrlCommand*)command
{

    _locService.delegate = self;

    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _callbackId = command.callbackId;
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    //NSLog(@"start locate");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    //NSLog(@"stop locate");
    _locService.delegate = nil;
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@ lat %f,long %f",userLocation.heading, userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locService stopUserLocationService];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary*dict=@{@"latitude":[NSNumber numberWithFloat:userLocation.location.coordinate.latitude],@"lontitude":[NSNumber numberWithFloat:userLocation.location.coordinate.longitude]};
    CDVPluginResult *pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];

    });
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *error_str=@"定位失败";
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error_str];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_callbackId];
    });
}


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end

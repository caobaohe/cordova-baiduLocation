//
//  BaiduLocation.h
//
//  Created by Jonah on 16-04-03.
//
//

#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface BaiduLocation : CDVPlugin <BMKLocationServiceDelegate,BMKGeneralDelegate> {

}

-(void)getCurrentPosition:(CDVInvokedUrlCommand*)command;


@end

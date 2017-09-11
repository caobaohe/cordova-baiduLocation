---
title: cordova-baiduLocation
description: cordova-plugin-geolocation定位在android上有时会定位失败，ios上会不稳定误差100米到2公里波动.
---

# cordova-baiduLocation 百度地图定位插件

## Installation
  
  >申请密钥 请参照：[申请密钥Android定位SDK](http://developer.baidu.com/map/index.php?title=android-locsdk/guide/key)
    
    $cordova plugin add https://github.com/caobaohe/cordova-baiduLocation.git --variable API_KEY="<API_KEY>"

## Supported Platforms
- Android
- iOS

        document.addEventListener("deviceready", onDeviceReady, false);
        function onDeviceReady() {
              baidu_location.getCurrentPosition(function (s) {
                alert(JSON.stringify(s));
                //var text = "百度坐标2：" + s.longitude + "," + s.latitude;
              }, function (e) {
                alert(JSON.stringify(e));
              });
        }
## ios build失败
![image](https://raw.githubusercontent.com/satya164/react-native-tab-view/master/demo/demo.gif)
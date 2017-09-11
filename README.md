
---
title: cordova-baiduLocation
description: cordova-plugin-geolocation定位在android上有时会定位失败，ios上会不稳定误差100米到2公里波动.
---

# cordova-baiduLocation
# 百度地图定位插件
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

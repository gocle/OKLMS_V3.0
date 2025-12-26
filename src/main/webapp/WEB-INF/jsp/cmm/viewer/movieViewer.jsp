<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<!-- 1. skin -->
<link rel="stylesheet" href="/flowplayer-7.2.7/skin/skin.css">
<!-- 2. jquery library -->
<script type="text/javascript" src="/js/jquery/jquery-1.11.1.js"></script>
<!-- 3. flowplayer -->
<script src="/flowplayer-7.2.7/flowplayer.min.js"></script>
<script>
// ===== Player 설정 !! 
flowplayer.conf.adaptiveRatio = false; 
flowplayer.conf.flashfit = false; 
flowplayer.conf.disabled = false;
flowplayer.conf.keyboard =true;  
flowplayer.conf.fullscreen = true; 
flowplayer.conf.live = false;  
flowplayer.conf.embed = false;
//flowplayer.conf.speeds = 0.25, 0.5, 1, 1.5, 2; -> FMS나 와우자 서버를 사용하지 않는한 안되는듯 함
flowplayer.conf.splash = false;  
flowplayer.conf.tooltip = false;
flowplayer.conf.autoPlay = true; // 자동 시작 아님
flowplayer.conf.volume = 1;
//flowplayer.conf.width = 900;
//flowplayer.conf.height = 900;
 
// ===== Player 이벤트 감시 !!
flowplayer(function(api, root) {
    // when a new video is about to be loaded
    api.bind("load", function() {
       console.info("load", api.engine);
    // when a video is loaded and ready to play
    }).bind("ready", function() {
       console.info("ready", api.video.duration);
        
    });
// 각종 이벤트 리스너들 ~ 
    api.bind("play", function() {
     });
    api.bind("resume", function() {
     });
     
    api.bind("stop", function() {
     });
     
    api.bind("pause", function() {
 
     });
     
    api.bind("seek", function() {
     });
    

     
 });
  
  
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<body style="margin:0px">
  
<div id="h-div" class="flowplayer play-button no-hover">
   <video autoplay="autoplay">
      <source type="video/mp4"  src="${param.movieUrl}">
   </video>
</div>
</html>
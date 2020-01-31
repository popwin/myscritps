#!/bin/bash

# ffmpeg 嵌入字幕脚本，其格式与ass tag为标准
# force_style格式参数见ass-tag.md中的粗体

# 1.加入双字幕时，使用 -vf 参数 添加字幕并且设定字幕格式
# 在设定格式时，marginV 是距离画面底部的距离

# 2. 如果仅仅嵌入单字幕，可以使用 -filter_complex 参数并且同时设定字幕格式

# 3. force_style中还可以加入的格式有 OutlineColour=&H100000000
# BorderStyle=3
# Outline=1
# Shadow=0
# MarginL=5 距离画面左面的距离

inputFile='xxxx.mp4'
filename2='xxxx.srt'
filename1='[xxx(en).srt'

subname='subs.srt'



ffmpeg -i $inputFile \
-filter_complex "subtitles='${subname}':force_style='FontName=Monospace Bold,FPrimaryColour=&H0000ff&,fontsize=14'" \
-b:v 2000k -c:a copy out.mp4

#ffmpeg -i $inputFile \
#-vf "subtitles='${filename1}':force_style='FontName=monospace,Fontsize=18,MarginV=30,Spacing=1'","subtitles='${filename2}':force_style='FontName=monospace,Fontsize=16,MarginV=01,Spacing=2'" \
#-b:v 2000k  -c:a copy \
#out5.avi


        
   

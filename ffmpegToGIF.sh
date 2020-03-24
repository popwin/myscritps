#!/bin/bash
#利用ffmpeg制作GIF

start_time=00:04:07 #要录制的GIF在视频中的起始时间
duration=44 # 时长

# -r 输出GIF的帧数
# -s 输出GIF的大小

ffmpeg -i air.mp4 -filter_complex "[0:v] palettegen" palette.png

ffmpeg -ss ${start_time} -t ${duration} -i air.mp4 -i palette.png -filter_complex "[0:v][1:v] paletteuse"  -s 360*280   -r 10 air.gif

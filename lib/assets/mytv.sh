#mpv "$1" --geometry=963x542+1+37 --vo=null --ao=null --no-resume-playback --stream-record=tv.mp4
vlc "$1" --sout='#standard{access=file,mux=ts,dst=tv.mp4}' --no-sout-all --sout-keep

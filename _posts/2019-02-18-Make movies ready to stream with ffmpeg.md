Powershell command to read all .mkv files from a folder, including sub folder then convert them to m4v

    $ffmpeg =  c:/apps/ffmpeg/bin/ffmpeg.exe
    Get-ChildItem -Filter '*.mkv' -Recurse | % { $ffmpeg -hide_banner -i "$($_.FullName)" -c:v libx264 -c:a aac -c:s mov_text -movflags faststart -y "l:/Streaming/$($_.BaseName).m4v" }


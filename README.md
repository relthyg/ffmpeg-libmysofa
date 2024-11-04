# ffmpeg-libmysofa

This Docker image builds an ffmpeg instance with `libmysofa` enabled on top of Arch Linux.

## Build

    docker build --tag ffmpeg-libmysofa .

## Usage

    docker run --rm -it -w=/app -v "$(pwd)":/app ffmpeg-libmysofa

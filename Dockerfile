FROM archlinux:latest as build

RUN pacman --noconfirm -Syu base-devel && \
  useradd -m archie && \
  echo "archie ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER archie
WORKDIR /home/archie

RUN curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/ffmpeg-git.tar.gz && \
  tar xzf ffmpeg-git.tar.gz && \
  cd ffmpeg-git && \
  sed -i '/libmodplug$/a libmysofa' PKGBUILD && \
  sed -i '/--enable-libmp3lame/a --enable-libmysofa \\' PKGBUILD && \
  makepkg --noconfirm --syncdeps --install

FROM archlinux:latest
COPY --from=build /usr/sbin/ffmpeg /usr/sbin/
COPY --from=build /usr/lib/* /usr/lib/

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

From ubuntu:16.04

ENV BUILD_PACKAGES build-essential pkg-config automake libtool git wget libboost-dev libboost-system-dev libboost-chrono-dev libboost-random-dev libssl-dev libgeoip-dev qtbase5-dev qttools5-dev-tools libqt5svg5-dev python

RUN apt-get update && \
    apt-get install geoip-database $BUILD_PACKAGES -y && \

    # Build libtorrent 1.0.11
    git clone https://github.com/arvidn/libtorrent.git && \
    cd libtorrent/ && \
    git checkout RC_1_0 && \
    ./autotool.sh && \
    .configure --prefix=/usr --disable-debug --enable-encryption --with-libgeoip=system CXXFLAGS=-std=c++11 && \
    make clean && \
    make && \
    make install && \
    cd .. && \

    # Download qBittorrent 3.3.11
    ldconfig && \
    wget https://github.com/qbittorrent/qBittorrent/archive/release-3.3.11.tar.gz && \
    tar -xzvf release-3.3.11.tar.gz && \
    cd qBittorrent-release-3.3.11/ && \
    ./configure --prefix=/usr --disable-gui && \
    make && \
    make install && \
    cd .. && \

    # Clean up
    apt-get purge -y $BUILD_PACKAGES && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf *.gz && \
    rm -rf /libtorrent && \
    rm -rf /qBittorrent-release-3.3.11

    # Add Config File
COPY qbittorrent /etc/init.d/
COPY qBittorrent.conf /root/.config/qBittorrent/

    # Chmod qBittorrent service
RUN chmod +x /etc/init.d/qbittorrent && \
    update-rc.d qbittorrent defaults && \
    echo "/etc/init.d/qbittorrent start">>/etc/bash.bashrc

VOLUME ["/downloads"]

EXPOSE 56789 54321

CMD ["/bin/bash"]


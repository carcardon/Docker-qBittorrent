## **Verison**
# latest：
qBittorrent-4.0.4 (libtorrent-1.1.17)

# 3.3.11：
qBittorrent-3.3.11 (libtorrent-1.0.11)

## **for Linux：**
`docker run -itd \`
`--name= <container name=> \`
`-p 54321:54321/tcp \`
`-p 54321:54321/udp \`
`-p 56789:56789/tcp \`
`-v <path to downloads>:/downloads \`
`madjack/qbittorrent`

## **for Synology DSM：**
設定Synoogy Nas本機資料夾對應到容器的資料夾 /downloads
Port 56789 / TCP (Webui Port,，Nas本機Port與容器Port需設定同為56789才能順利開啟WebUI)
54321 / TCP (Connect Port)
54321 / UDP (Connect Port)

The WebUI running on **<http://localhost:56789/>**

default user:**admin** 

default password:**adminadmin**


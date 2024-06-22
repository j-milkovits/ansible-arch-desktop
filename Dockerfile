FROM archlinux:latest

 # install packages when building to save some time
RUN pacman -Sy --noconfirm && \
    pacman -S sudo ansible dialog --noconfirm && \
    useradd -m jonas && \
    echo 'jonas:sudo_pw' | chpasswd && \
    usermod -aG wheel jonas && \
    echo 'jonas ALL=(ALL) ALL' >> /etc/sudoers

USER jonas
WORKDIR /home/jonas 

COPY . .

CMD bash

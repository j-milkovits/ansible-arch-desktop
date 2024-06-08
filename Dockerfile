FROM archlinux:latest

RUN pacman -Sy --noconfirm && \
    pacman -S sudo --noconfirm && \
    useradd -m jonas && \
    echo 'jonas:sudo_pw' | chpasswd && \
    usermod -aG wheel jonas && \
    echo 'jonas ALL=(ALL) ALL' >> /etc/sudoers

USER jonas
WORKDIR /home/jonas 

COPY . .

CMD bash

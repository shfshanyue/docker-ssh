From buildpack-deps:xenial
MAINTAINER shanyue <xianger94@gmail.com>

RUN apt-get update -y
RUN apt-get install -y openssh-server --no-install-recommends
RUN mkdir -p /var/run/sshd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' /etc/pam.d/sshd

RUN apt-get install -y --no-install-recommends zsh \
                                               git \
                                               vim \
                                               tmux \
                                               nodejs

RUN apt-get install sudo -y --no-install-recommends
RUN useradd -m -u 1000 -g sudo -s /bin/zsh -p development dev
RUN echo dev:development | chpasswd

USER 1000
WORKDIR /home/dev
EXPOSE 22
CMD /usr/sbin/sshd -D

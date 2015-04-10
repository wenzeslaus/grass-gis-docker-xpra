# This file creates a container that runs X11 and SSH services
# The ssh is used to forward X11 and provide you encrypted data
# communication between the docker container and your local
# machine.
#
# Xpra allows to display the programs running inside of the
# container such as Firefox, LibreOffice, xterm, etc.
# with disconnection and reconnection capabilities
#
# Xephyr allows to display the programs running inside of the
# container such as Firefox, LibreOffice, xterm, etc.
#
# Fluxbox and ROX-Filer creates a very minimalist way to
# manages the windows and files.
#
# GRASS GIS is compiled and installed from 7.0 release branch from SVN.
#
# Authors:
#   Roberto Gandolfo Hashioka (non-GRASS part, rogaha/docker-desktop)
#   Vaclav Petras


FROM ubuntu:14.04
MAINTAINER Vaclav Petras <wenzeslaus@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN apt-get install -y xpra rox-filer openssh-server pwgen xserver-xephyr xdm fluxbox xvfb sudo

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# Upstart and DBus have issues inside docker. We work around in order to install firefox.
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get install -y xterm

RUN sudo apt-get update
RUN sudo apt-get upgrade

# not used because repositories were somehow broken when tested
# RUN apt-get install -y software-properties-common python-software-properties
# RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
# RUN add-apt-repository -y ppa:grass/grass-devel
# RUN apt-get update
# RUN apt-get install -y grass70

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Copy the files into the container
ADD . /src

RUN /bin/bash /src/grass_dependencies.sh

WORKDIR /usr/local/src

RUN /bin/bash /src/grass_compile.sh

EXPOSE 22
# Start xdm and ssh services.
CMD ["/bin/bash", "/src/startup.sh"]

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y \
	build-essential \
	openssh-server \
	sudo \
	qt5-default \
	qt5-doc \
	qt5-doc-html \
	qt5-qmake \
	qtbase5-doc-html \
	qtbase5-examples \
	qtcreator

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
	
USER developer
ENV HOME /home/developer
ENV PATH /usr/lib/qt5/bin:$PATH

CMD /usr/bin/qtcreator
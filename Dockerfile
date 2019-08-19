FROM ubuntu:16.04

RUN apt update && apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:RootPassword' | chpasswd
RUN sed -i 's/\(PermitRootLogin\) prohibit-password/\1 yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


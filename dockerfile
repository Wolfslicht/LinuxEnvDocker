# use fedora as base image
FROM fedora:latest

# update the system
RUN dnf update -y
# install packages needed for python development, including pip and git 
RUN dnf install -y python3 python3-pip git

# install useful packages for fedora
RUN dnf install -y vim wget curl

# install vscode gui
RUN dnf install -y code

# install remote desktop using xrdp including ssh server and client and access to the ssh server
RUN dnf install -y xrdp tigervnc-server openssh-server openssh-clients
RUN systemctl enable sshd
RUN systemctl enable xrdp
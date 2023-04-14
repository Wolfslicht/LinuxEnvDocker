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

# install extensions like app indicator support for fedora, notifications banner reloaded, quick settings tweaker, light and dark theme switcher, and user themes and extension manager
RUN dnf install -y gnome-shell-extension-appindicator gnome-shell-extension-notification-banners-reloaded gnome-shell-extension-quicktweaks gnome-shell-extension-theme-switcher gnome-shell-extension-user-theme gnome-shell-extension-extensions

# install user apps like 1password, chrome browser, telegram, whatsapp and discord, as well as geary mail, office 365, nextcloud desktop client, and spotify. synology drive client
RUN dnf install -y 1password google-chrome-stable telegram-desktop whatsapp-for-linux discord geary office365-client nextcloud-client spotify-client synology-drive-client

# install development tools like nodejs, npm, yarn, java, maven, gradle, and docker
RUN dnf install -y nodejs npm yarn java-11-openjdk-devel maven gradle docker

# install python packages
RUN pip3 install --upgrade pip

# create user named "wolf" with inital password "wolf"
RUN useradd -m -p $(openssl passwd -1 wolf) wolf
# add user "wolf" to sudoers
RUN echo "wolf ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# allow user Wolf to access remote desktop and ssh
RUN echo "wolf" >> /etc/xrdp/sesman.ini

# set the working directory to /home/wolf
WORKDIR /home/wolf

# create a welcome message
RUN echo "Welcome to the wolf's den!" >> /home/wolf/welcome.txt

# start programs on login
RUN echo "code" >> /home/wolf/.bashrc

# create best-practice devops bash aliases
RUN echo "alias ll='ls -alF'" >> /home/wolf/.bashrc
# more aliases
RUN echo "alias la='ls -A'" >> /home/wolf/.bashrc
RUN echo "alias l='ls -CF'" >> /home/wolf/.bashrc
RUN echo "alias ..='cd ..'" >> /home/wolf/.bashrc
RUN echo "alias ...='cd ../..'" >> /home/wolf/.bashrc
RUN echo "alias ....='cd ../../..'" >> /home/wolf/.bashrc
RUN echo "alias .....='cd ../../../..'" >> /home/wolf/.bashrc
RUN echo "alias .4='cd ../../..'" >> /home/wolf/.bashrc
RUN echo "alias .5='cd ../../../..'" >> /home/wolf/.bashrc
RUN echo "alias .6='cd ../../../../..'" >> /home/wolf/.bashrc
RUN echo "alias .7='cd ../../../../../..'" >> /home/wolf/.bashrc
RUN echo "alias .8='cd ../../../../../../..'" >> /home/wolf/.bashrc
RUN echo "alias .9='cd ../../../../../../../..'" >> /home/wolf/.bashrc
RUN echo "alias mkdir='mkdir -pv'" >> /home/wolf/.bashrc
RUN echo "alias wget='wget -c'" >> /home/wolf/.bashrc
RUN echo "alias grep='grep --color=auto'" >> /home/wolf/.bashrc
RUN echo "alias fgrep='fgrep --color=auto'" >> /home/wolf/.bashrc
RUN echo "alias egrep='egrep --color=auto'" >> /home/wolf/.bashrc
RUN echo "alias df='df -h'" >> /home/wolf/.bashrc
RUN echo "alias du='du -h'" >> /home/wolf/.bashrc
RUN echo "alias free='free -m'" >> /home/wolf/.bashrc
RUN echo "alias ps='ps -ef'" >> /home/wolf/.bashrc
RUN echo "alias top='top -o cpu'" >> /home/wolf/.bashrc
RUN echo "alias kill='kill -9'" >> /home/wolf/.bashrc
RUN echo "alias kill9='kill -9'" >> /home/wolf/.bashrc
RUN echo "alias killall='killall -9'" >> /home/wolf/.bashrc
RUN echo "alias killall9='killall -9'" >> /home/wolf/.bashrc
RUN echo "alias shutdown='shutdown -h now'" >> /home/wolf/.bashrc
RUN echo "alias reboot='shutdown -r now'" >> /home/wolf/.bashrc
RUN echo "alias halt='shutdown -h now'" >> /home/wolf/.bashrc
RUN echo "alias poweroff='shutdown -h now'" >> /home/wolf/.bashrc
RUN echo "alias update='dnf update -y'" >> /home/wolf/.bashrc
RUN echo "alias upgrade='dnf upgrade -y'" >> /home/wolf/.bashrc
RUN echo "alias install='dnf install -y'" >> /home/wolf/.bashrc
RUN echo "alias remove='dnf remove -y'" >> /home/wolf/.bashrc
RUN echo "alias autoremove='dnf autoremove -y'" >> /home/wolf/.bashrc
RUN echo "alias clean='dnf clean all'" >> /home/wolf/.bashrc
RUN echo "alias autoclean='dnf autoclean'" >> /home/wolf/.bashrc
RUN echo "alias cleanall='dnf clean all && dnf autoclean'" >> /home/wolf/.bashrc
RUN echo "alias clearcache='dnf clean all && dnf autoclean'" >> /home/wolf/.bashrc

# set bootup information when accessing ssh, including important information about the system like CPU, RAM, and disk usage as well as remote ip address and hostname
RUN echo "echo 'Welcome to the wolf's den!'" >> /home/wolf/.bashrc
RUN echo "echo 'Your IP address is: '" >> /home/wolf/.bashrc
RUN echo "echo $SSH_CLIENT | awk '{ print $1}'" >> /home/wolf/.bashrc
RUN echo "echo 'Your hostname is: '" >> /home/wolf/.bashrc
RUN echo "echo $SSH_CLIENT | awk '{ print $2}'" >> /home/wolf/.bashrc
RUN echo "echo 'Your CPU is: '" >> /home/wolf/.bashrc
RUN echo "cat /proc/cpuinfo | grep 'model name' | uniq | awk -F: '{print $2}'" >> /home/wolf/.bashrc
RUN echo "echo 'Your RAM is: '" >> /home/wolf/.bashrc
RUN echo "free -m | awk 'NR==2{printf \"Memory Usage: %s/%sMB (%.2f%%)\", $3,$2,$3*100/$2 }'" >> /home/wolf/.bashrc
RUN echo "echo 'Your disk is: '" >> /home/wolf/.bashrc
RUN echo "df -h | awk '$NF==\"/\"{printf \"Disk Usage: %d/%dGB (%s)\", $3,$2,$5}'" >> /home/wolf/.bashrc

# start cmd
CMD ["/usr/sbin/init"]






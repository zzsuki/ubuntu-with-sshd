FROM ubuntu:18.04
MAINTAINER "zzsuki"

# set tz env
ENV TZ=Asia/Shanghai
# set root password
ENV ROOT_PASSWORD=root
# change apt source and install some basic tools
COPY ./sources.list /etc/apt/
RUN apt-get update && apt-get install -y iputils-ping openssl tcpreplay tcpdump hping3 iperf3 iperf net-tools vim curl wget nmap sysbench fio
# modify sshd_config to allow root login
RUN mkdir /run/sshd; \
    apt install -y openssh-server; \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;
# add user bolean and set password
RUN useradd -rm -d /home/zzsuki -s /bin/bash -g root -G sudo -u 1001 -p "$(openssl passwd -1 zzsuki)" zzsuki

# exporse prot
EXPOSE 22

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

# modify entrypoint to make long live
ENTRYPOINT ["entry_point.sh"]
CMD    ["/usr/sbin/sshd", "-D", "-e"]

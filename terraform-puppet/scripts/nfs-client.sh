sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F

sudo yum -y install nfs-utils

# Firewall settings for NFS not needed for POC but reference
#sudo firewall-cmd --zone=public --add-port=2049/tcp --add-port=2049/udp --add-port=111/tcp --add-port=111/udp --add-port=32803/tcp --add-port=32769/udp --add-port=892/tcp --add-port=892/udp --add-port=662/tcp --add-port=662/udp
#sudo firewall-cmd --permanent --zone=public --add-port=2049/tcp --add-port=2049/udp --add-port=111/tcp --add-port=111/udp --add-port=32803/tcp --add-port=32769/udp --add-port=892/tcp --add-port=892/udp --add-port=662/tcp --add-port=662/udp

sudo mkdir /nfs

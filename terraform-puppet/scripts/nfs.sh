sudo sfdisk /dev/sdb < /tmp/master.layout

mkfs.xfs /dev/sdb1
sudo mkdir /mnt/nfs
sudo mount /dev/sdb1 /mnt/nfs
sudo bash -c 'sdb_uuid=`sudo blkid /dev/sdb1 -s UUID -o value` && echo "UUID=$sdb_uuid    /mnt/nfs    xfs    defaults,noatime,_netdev,nofail" >> /etc/fstab'

### NFS setup
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F

# Firewall setting for NFS. Not needed for POC
#sudo firewall-offline-cmd --zone=public --add-service=nfs

sudo yum -y install nfs-utils
sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service
sudo chown nfsnobody:nfsnobody /mnt/nfs/
sudo chmod 777 /mnt/nfs/
cidr=`ip addr show dev ens3 | grep "inet " | awk -F' ' '{print $2}'`
sudo bash -c 'echo "/mnt/nfs $0(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports' $cidr
sudo exportfs -a

### YUM update
sudo yum update -y

### Firewall
#sudo systemctl restart firewalld.service

sudo sfdisk /dev/sdb < /tmp/volume.layout
sudo mkfs.xfs /dev/sdb1
sudo mkdir /u01
sudo mount /dev/sdb1 /u01
sudo bash -c 'sdb_uuid=`sudo blkid /dev/sdb1 -s UUID -o value` && echo "UUID=$sdb_uuid    /u01    xfs    defaults,noatime,_netdev,nofail" >> /etc/fstab'

for i in 2 3 4
  do
    sudo mkfs.xfs /dev/sdb$i
    sudo mkdir /u0$i
    # Currently not mounting, uncomment to mount
    # sudo mount /dev/sdb$i /u0$i
    # sudo bash -c 'sdb_uuid=`sudo blkid /dev/sdb$0 -s UUID -o value` && echo "UUID=$sdb_uuid    /u0$0    xfs    defaults,noatime,_netdev,nofail" >> /etc/fstab' $i
  done

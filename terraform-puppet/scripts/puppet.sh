tar -xf /tmp/puppet-enterprise-2017.3.2-el-7-x86_64.tar.gz

cd puppet-enterprise-2017.3.2-el-7-x86_64/

sudo ./puppet-enterprise-installer -c /tmp/pe.conf

sudo bash -c 'echo "*" > /etc/puppetlabs/puppet/autosign.conf'
wait

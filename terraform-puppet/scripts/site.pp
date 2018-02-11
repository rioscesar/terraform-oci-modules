## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
package { 'oracle-rdbms-server-12cR1-preinstall':
  ensure => 'installed',
}


$all_groups = ['oinstall','dba' ,'oper']
group { $all_groups :
ensure      => present,
}
user { 'oracle' :
ensure      => present,
uid         => 500,
gid         => 'oinstall',
groups      => ['oinstall','dba','oper'],
shell       => '/bin/bash',
password    => '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.',
home        => "/home/oracle",
comment     => "This user oracle was created by Puppet",
require     => Group[$all_groups],
managehome  => true,
}

sysctl { 'kernel.msgmnb':                 ensure => 'present', permanent => 'yes', value => '65536',}
sysctl { 'kernel.msgmax':                 ensure => 'present', permanent => 'yes', value => '65536',}
sysctl { 'kernel.shmmax':                 ensure => 'present', permanent => 'yes', value => '2588483584',}
sysctl { 'kernel.shmall':                 ensure => 'present', permanent => 'yes', value => '2097152',}
sysctl { 'fs.file-max':                   ensure => 'present', permanent => 'yes', value => '6815744',}
sysctl { 'net.ipv4.tcp_keepalive_time':   ensure => 'present', permanent => 'yes', value => '1800',}
sysctl { 'net.ipv4.tcp_keepalive_intvl':  ensure => 'present', permanent => 'yes', value => '30',}
sysctl { 'net.ipv4.tcp_keepalive_probes': ensure => 'present', permanent => 'yes', value => '5',}
sysctl { 'net.ipv4.tcp_fin_timeout':      ensure => 'present', permanent => 'yes', value => '30',}
sysctl { 'kernel.shmmni':                 ensure => 'present', permanent => 'yes', value => '4096', }
sysctl { 'fs.aio-max-nr':                 ensure => 'present', permanent => 'yes', value => '1048576',}
sysctl { 'kernel.sem':                    ensure => 'present', permanent => 'yes', value => '250 32000 100 128',}
sysctl { 'net.ipv4.ip_local_port_range':  ensure => 'present', permanent => 'yes', value => '9000 65500',}
sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '4194304', }
sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '1048576',}
class { 'limits':
config => {
           '*'       => { 'nofile'  => { soft => '2048'   , hard => '8192',   },},
           'oracle'  => { 'nofile'  => { soft => '65536'  , hard => '65536',  },
                           'nproc'  => { soft => '2048'   , hard => '16384',  },
                           'stack'  => { soft => '10240'  ,},},
           },
use_hiera => false,
}
package { ['ksh',
             'gcc',
             'libaio',
             'libaio-devel',
             'compat-libstdc++-33',
             'elfutils-libelf-devel',
             'glibc-devel',
             'glibc-headers',
             'gcc-c++',
             'libstdc++-devel',
             'sysstat',
             'psmisc']:
      ensure => 'present',
  }

oradb::installdb { '12.1.0.2_Linux-x86-64':
  version                   => '12.1.0.2',
  file                      => 'linuxamd64_12102_database',
  database_type             => 'EE',
  ora_inventory_dir         => '/etc/opt',
  oracle_base               => '/u01/app/oracledb-12c',
  oracle_home               => '/u01/app/oracledb-12c/product/12.1.0/db1',
  bash_profile              => true,
  user                      => 'oracle',
  group                     => 'dba',
  group_install             => 'oinstall',
  group_oper                => 'oinstall',
  download_dir              => '/nfs/oracle.installer',
  zip_extract               => true,
  puppet_download_mnt_point => "/nfs",
} 
} 
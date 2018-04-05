sudo bash -c "mv /tmp/StateInsurance.sql /home/oracle/ && chmod 777 /home/oracle/StateInsurance.sql"
sudo su - oracle -c "export ORACLE_SID=aTFdb && export ORAENV_ASK=NO && . /usr/local/bin/oraenv && exit | sqlplus / as sysdba @/home/oracle/StateInsurance.sql"

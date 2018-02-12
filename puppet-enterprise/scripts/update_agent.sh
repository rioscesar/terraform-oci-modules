FILE="/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock"
while [ -f $FILE ]; do
    echo "Lock file exists"
    sleep 10
done

sudo /opt/puppetlabs/bin/puppet agent -t
wait


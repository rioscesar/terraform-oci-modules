import re
 
warPath = '/u01/oracle/HelloWorldWebService.war'
appName = 'mytestapplication'

weblogicUrl = '129.157.177.46:7002'
userName = 'welcome'
password = 'Devops_123'

connect(userName, password, weblogicUrl)
 
appList = re.findall(appName, ls('/AppDeployments'))
if len(appList) >= 1:
    print 'undeploying application'
    undeploy(appName)
 
deploy(appName, path = warPath, retireTimeout = -1, upload = 'True')
exit()


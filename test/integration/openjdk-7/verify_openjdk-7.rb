# the right version of java is installed
describe command('java -version 2>&1') do
  its('stdout') { should match /1\.7\.0/ }
end

unless os.bsd?
  # alternatives were properly set
  describe command('alternatives --display jar') do
    its('stdout') { should match /java-1\.7\.0/ }
  end
end

# the cert was installed into the keystore
describe command('$JAVA_HOME/bin/keytool -list -storepass changeit -keystore $JAVA_HOME/jre/lib/security/cacerts -alias java_certificate_test') do
  its('stdout') { should match /9D:9E:EA:E6:5F:D2:C8:34:93:6E:5C:65:EE:00:46:A9:CD:E4:F1:83/ }
end

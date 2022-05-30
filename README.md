# Ecolo


## Run Ecolo virtual IoT device
```bash
node ecolo_virtual_iot_device.js  mqttDeviceDemo \  
--projectId=ecolo-350814     \
--cloudRegion=asia-east1     \
--registryId=ecolo-registry     \
--deviceId=ecolo-electricity-sensor     \
--privateKeyFile=rsa_private.pem     \
--serverCertFile=roots.pem     \
--numMessages=25     \
--algorithm=RS256
```
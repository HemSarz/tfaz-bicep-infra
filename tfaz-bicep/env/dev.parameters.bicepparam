using '../main.bicep'

param resourceGroupNEParam = {
  name: 'tfaz-rg-ne-dev'
  location: 'norwayeast'
}

param tagsParam = {
  owner: 'hemsarza'
  environment: 'dev'
  application: 'tfaz-bicep'
  workload: 'tfaz-bicep-infra'
}

param vnetParam = {
  name: 'tfaz-vnet-ne-dev'
  addressPrefix: '10.0.0.0/16'
  subnetAddressPrefix: '10.0.0.0/24'
  subnetName: 'tfaz-subnet-ne-dev'
}

param vmParam = {
  name: 'tfaz-vm-ne-dev'
  size: 'Standard_B1s'
  imageReference: {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18.04-LTS'
    version: 'latest'
  }
  adminUsername: 'agentpool'

  sshPublicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIPYrW0cPUQRlCjrMnUvEM2xCwfp1uXwBgAuvOIL0RDwMA9qSYwogyHaf2wGeV5EGwnyRrpuy326U5w+dXswBhJdLktM5ssX4EKFGisdQF9UjtMsniwxBDLGkaBxmeB7nIjqMrJ0hvTNzo9IBNlIdNNsoSBo3zlpEh+liPc3LxJb/+bsUQplQUwI1RAwaWaHbBRm9D4RiMum3jIZLUAF5q63HlQo/EXJvURRX+oh1XnkHsZEqKML7csGz4w9unmYMbK3pOoMHkRZz84WiqCzX1zSz6wODUzunsvnu9qFpLR4U4IRg60rAcPWylIe53B2gfh8Z8ZCX0Qm+dAh4TZHoBKA/rxwmGyithndw8eDy7gMzaC4+WUT+Ivp+ECivjs67o/zaqT0wuetlHJsVGWTx1b+fs6hVgH9Lmqhsl8NFhwFeMAUteH/r9+aMbUBWiBYeoF6Cifj1CH3tui4j5oEG1xmhY7I0FI7fTwehS686s52DOp9wcIDpSaVBv+kGYhyB4ZF1SYSYg+WyYG3gvCCt9f7TI9vNx6Vd+66KD79Tu+221wPyMbAVwH8b+MsdXofA7DN8jX5sYHXf3bj8+/GMKDOcsaxFpPOQlYfxJ1Mc1ux8q5vWxOmnQLQucixAjWhdaXmiUUxyEN9yieyIVBbpKVF5xOK8Ej+xH1/6pP+auxQ== one\\ahemsarza@PCNOR320309'
}

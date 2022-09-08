# Installing the Domain Controller

Windows Server Eval 2022

1 Used Sconfig to:
    Change hosstname
    Change IP address to static
    Change DNS server to new static IP

2 Installed Active Directory Windows Feautre

    ```shell
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
    ```

3 Installed Forest and established AD name (Bussin.com)
    
    ```shell
    Import-Module ADDSDeployment
    Install-ADDSForest
    ```

4 Set DNS server IP back to Self

    ```shell
    Get-NetIPAddress
    ```

    Found Ethernet0 index

    ```
    Set-DnsClientServerAddress -InterfaceIndex (Index Value) -ServerAddresses (Static IP)
    ```
    
    Note:
        Can be done through Sconfig but chose to be cool
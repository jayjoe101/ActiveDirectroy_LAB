# Connecting Workstations to the Domain

1 Set DNS server to DC static IP

    ```shell
        Get-NetIPAddress
    ```

    Found Ethernet0 index

    ```
    Set-DnsClientServerAddress -InterfaceIndex (Index Value) -ServerAddresses (Static IP)
    ```

2 Connect Computer to DC

    ```shell
    Add-Computer -DomainName (Name) -Credential (Name\useraccount) -Force -Restart
    ```
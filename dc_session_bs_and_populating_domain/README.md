# Getting all the peeps in place and the session stuff needed

1 Create a PSSession to the DC from admin

    ```shell
    $dc = New-PSSession -ComputerName (dcip) -Credential (Get-Credential)
    ```

2 Create a AD json from random_schema.ps1 (configure how many users/groups wanted)

3 Copy code and json from admin to dc

    ```shell
    cp .\gen_ad.ps1 -ToSession $dc C:\Windows\Tasks
    cp .\out.json -ToSession $dc C:\Windows\Tasks
    ```

4 Execute gen_ad.ps1 onto dc
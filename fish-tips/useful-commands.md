- Set script location as working directory
    ```fish
    #!/usr/bin/fish
    set -gx DIR (cd (dirname (status -f)); and pwd)
    #code here
    set -e DIR
    ```

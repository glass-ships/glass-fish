- Set script location as working directory
    ```
    #!/usr/bin/env fish
    set -gx DIR (cd (dirname (status -f)); and pwd)
    #code here
    set -e DIR
    ```

- Source a bash script (requires EDC/Bass)
    - 

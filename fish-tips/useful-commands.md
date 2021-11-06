- Set script location as working directory:
    ```
    #!/usr/bin/env fish
    set DIR (dirname (status --current-filename))
    # do stuff 
    set -e DIR
    ```

    or if it's a sym-link and you need the real file path:

    ```
    #!/usr/bin/env fish
    set DIR (dirname (readlink -m (status --current-filename)))
    # do stuff
    set -e DIR
    ```

- Source a bash script (requires EDC/Bass)
    - 

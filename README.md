# Glass's Custom Fish Environment #

Custom fish fish environment with a (kinda) pretty prompt, and some convenience aliases and functions.

## Contents ##

[`setup.fish`](setup.fish): Initializes shell environment: 
- Symlinks repo to `~/.config/fish`
- Copies VIM settings so it behaves how I personally like
- Checks for SSH key, creates if missing
- Sets Git user name and email (user input)
- Adds some global default git ignores  

[`config.fish`](config.fish): Sets some options, source scripts and set variables, and defines some useful functions and aliases

[`functions/fish_prompt.fish`](functions/fish_prompt.fish): Sets the custom prompt. Also removes the welcome message

[`fish_variables`](fish_variables): Sets some universal variables for fish (mostly colors). Editing this directly is not recommended. Instead, edit any variables in `config.fish`

[`fish-tips`](fish-tips): Just some useful chunks of fish code

[`vimrc`](vimrc): VIM settings tweaked to my liking, feel free to edit to yours. Sourced by `config.fish`

[`secrets-template.fish`](secrets-template.fish): Template script to set API keys and other secrets as environment variables. Add your secrets and rename to `secrets.fish`. Sourced by `config.fish`

## Setup ##

1. Clone the repo  
    `><> git clone https://gitlab.com/glass-ships/glass-fish.git`

1. Initialize new environment:  
    `><> cd glass-fish ;; fish setup.fish`

1. Rename `secrets-template` to `secrets` and enter your private things to keep them safe  
    NOTE: `secrets` is ignored, so your secrets are safe if you contribute to this repository

1. (Optional) For plugin management, install [fisher](https://github.com/jorgebucaran/fisher) or [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)

1. (Optional) For BASH compatibility, add [EDC/Bass](https://github.com/edc/bass)

1. Enjoy!

## Contributing

This repo could probably use some regular TLC. If you're interested in helping out, just create an issue, or fork the repo and merge request back in! 

~ Glass

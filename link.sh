#!/bin/zsh

links_to_check=(~/.config/nvim ~/.config/tmux ~/.config/ghostty ~/.zshrc)
expected_targets=("$PWD/nvim" "$PWD/tmux" "$PWD/ghostty" "$PWD/zsh/.zshrc")

for i in {1..${#links_to_check[@]}}; do

    current_link="${links_to_check[i]}"
    expected_target="${expected_targets[i]}"
    echo "Checking: $current_link"

    if [[ ! -e "$current_link" ]]; then
        echo "Error: $current_link does not exist."
        echo "Linking $current_link to $expected_target"
        ln -s "$expected_target" "$current_link"
        continue
    fi

    if [[ ! -L "$current_link" ]]; then
        echo "Error: $current_link is not a symbolic link."
        continue
    fi

    actual_target=$(readlink -f "$current_link")

    if [[ "$actual_target" == "$expected_target" ]]; then
        echo "Success: $current_link points to the expected file."
    else
        echo "Error: $current_link does not point to the expected file."
    fi

done

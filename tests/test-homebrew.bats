#!/usr/bin/env bats

@test "Homebrew is installed" {
    command -v brew
}

@test "Homebrew version command works" {
    brew --version
}

@test "Homebrew doctor runs without critical errors" {
    # brew doctor may have warnings, but should not fail completely
    run brew doctor
    # Exit code 0 or 1 are acceptable (1 may have warnings)
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "Homebrew config shows correct installation" {
    brew config
}

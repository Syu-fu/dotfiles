#!/usr/bin/env bats

setup() {
	export TEST_COMPLETION_DIR="$HOME/.config/zsh/completions"
}

@test "Completions directory exists" {
	[ -d "$TEST_COMPLETION_DIR" ]
}

@test "gh completion file exists if gh is installed" {
	if command -v gh >/dev/null 2>&1; then
		[ -f "$TEST_COMPLETION_DIR/_gh" ]
	else
		skip "gh not installed"
	fi
}

@test "fd completion file exists if fd is installed" {
	if command -v fd >/dev/null 2>&1; then
		[ -f "$TEST_COMPLETION_DIR/_fd" ]
	else
		skip "fd not installed"
	fi
}

@test "deno completion file exists if deno is installed" {
	if command -v deno >/dev/null 2>&1; then
		[ -f "$TEST_COMPLETION_DIR/_deno" ]
	else
		skip "deno not installed"
	fi
}

@test "rustup completion file exists if rustup is installed" {
	if command -v rustup >/dev/null 2>&1; then
		[ -f "$TEST_COMPLETION_DIR/_rustup" ]
	else
		skip "rustup not installed"
	fi
}

@test "cargo completion file exists if rustup is installed" {
	if command -v rustup >/dev/null 2>&1; then
		[ -f "$TEST_COMPLETION_DIR/_cargo" ]
	else
		skip "rustup not installed"
	fi
}

@test "Completion files are valid zsh scripts" {
	for completion_file in "$TEST_COMPLETION_DIR"/_*; do
		if [ -f "$completion_file" ]; then
			# Check if file starts with #compdef or #autoload
			run head -1 "$completion_file"
			[[ "$output" =~ ^#(compdef|autoload) ]] || [[ "$output" =~ ^# ]]
		fi
	done
}

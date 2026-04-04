#!/usr/bin/env bash
#
# Tests for the lint script. Run with: bash test/lint_test.sh

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LINT="$DOTFILES_ROOT/bin/lint"

pass=0
fail=0

assert_eq() {
  local description="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    echo "  PASS: $description"
    pass=$((pass + 1))
  else
    echo "  FAIL: $description"
    echo "    expected: $expected"
    echo "    actual:   $actual"
    fail=$((fail + 1))
  fi
}

assert_exit_zero() {
  local description="$1"
  shift
  if "$@" > /dev/null 2>&1; then
    echo "  PASS: $description"
    pass=$((pass + 1))
  else
    echo "  FAIL: $description (exit code: $?)"
    fail=$((fail + 1))
  fi
}

assert_exit_nonzero() {
  local description="$1"
  shift
  if "$@" > /dev/null 2>&1; then
    echo "  FAIL: $description (expected failure, got success)"
    fail=$((fail + 1))
  else
    echo "  PASS: $description"
    pass=$((pass + 1))
  fi
}

# --- Test: lint script exists and is executable ---
echo "lint script basics"
assert_eq "lint script exists" "true" "$(test -f "$LINT" && echo true || echo false)"
assert_eq "lint script is executable" "true" "$(test -x "$LINT" && echo true || echo false)"

# --- Test: fish syntax validation ---
echo "fish syntax validation"
assert_exit_zero "valid fish files pass syntax check" \
  "$LINT" fish

# --- Test: shellcheck validation ---
echo "shellcheck validation"
assert_exit_zero "shell scripts pass shellcheck" \
  "$LINT" sh

# --- Test: running all checks ---
echo "all checks"
assert_exit_zero "lint with no args runs all checks" \
  "$LINT"

# --- Summary ---
echo ""
echo "Results: $pass passed, $fail failed"
[ "$fail" -eq 0 ] || exit 1

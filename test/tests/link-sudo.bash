test_description='sudo creates symlinks with root'
. '../test-lib.bash'

test_expect_success 'setup' '
echo "apple" > ${DOTFILES}/f &&
echo "banana" > ${DOTFILES}/f-sudo
'

test_expect_success 'run' '
run_dotbot <<EOF
- link:
    ~/.f:
      path: f
      sudo: false
    ~/.f-sudo:
      path: f-sudo
      sudo: true
EOF
'

test_expect_success 'test' '
test "$(stat -c "%u" ~/.f)" -ne 0 &&
test "$(stat -c "%u" ~/.f-sudo)" -eq 0
'

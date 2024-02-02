export ASDF_DIR=$(brew --prefix asdf)/libexec
# export ASDF_DATA_DIR=/Users/bstraub/Code/zendesk/.asdf

# source $(brew --prefix asdf)/libexec/asdf.sh

# Ruby compile flags
export CPPFLAGS="$CPPFLAGS -DHAVE_UNISTD_H"
export RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC


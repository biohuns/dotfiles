#!/bin/bash

set -eux

brew install fish \
             pyenv \
             rbenv \
             nodenv \
             go \
             dep \
             ghq \
             peco \
             z \
             tig \
             jq \
#chsh -s /usr/local/bin/fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# gRPC
go get -u google.golang.org/grpc
brew install protobuf
go get -u github.com/golang/protobuf/protoc-gen-go

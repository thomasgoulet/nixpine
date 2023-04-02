FROM alpine:latest

ARG DEFAULT_USER=thomas
ARG DEFAULT_PASS=thomas
ARG DOTFILES_REPO=https://github.com/thomasgoulet/nixpine.git

# Dependencies needed for nix installation / curl sudo tar xz
# Group & user management / shadow openssl
# Installing flake / git
# Default shell / bash
RUN apk add --no-cache bash openssl git shadow curl sudo tar xz && \
  echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel && \
  addgroup nixbld && \
  useradd -m -U -G nixbld,wheel -s /bin/bash -p $(echo $DEFAULT_PASS | openssl passwd -1 -stdin) $DEFAULT_USER && \
  mkdir -m 0755 /nix && chown $DEFAULT_USER /nix

# Download script
RUN curl -L https://nixos.org/nix/install > /home/$DEFAULT_USER/nix.sh && \
  chmod +x /home/$DEFAULT_USER/nix.sh && \
  chown $DEFAULT_USER:$DEFAULT_USER /home/$DEFAULT_USER/nix.sh

# Installation is user only
USER $DEFAULT_USER
ENV USER=$DEFAULT_USER
WORKDIR /home/$DEFAULT_USER

# Run install script and clean it
RUN mkdir .config .config/nix && \
  printf "sandbox = false\nexperimental-features = nix-command flakes" > .config/nix/nix.conf && \
  touch .profile && \
  ./nix.sh --no-daemon && \
  source .profile && \
  rm -r nix.sh .config .profile

# Install my home-manager configuration / Step is not cached if new commit
RUN git clone --bare $DOTFILES_REPO ~/.dotfiles && \
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

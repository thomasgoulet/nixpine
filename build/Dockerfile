FROM alpine:latest

ARG DEFAULT_USER=thomas
ARG DEFAULT_PASS=thomas
ARG NIX_FLAKE_REPO=https://github.com/thomasgoulet/nixpine.git

# Dependencies needed for nix installation / curl sudo tar xz
# Group & user management / shadow openssl
# Installing flake / git
# Default shell / bash
RUN apk add --no-cache bash curl openssl git shadow sudo tar xz

# Enable group wheel to use sudo
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

# Add the users and groups
RUN addgroup nixbld
RUN useradd -m -U -G nixbld,wheel -s /bin/bash -p $(echo $DEFAULT_PASS | openssl passwd -1 -stdin) $DEFAULT_USER

# Setup nix folder
RUN mkdir -m 0755 /nix && chown $DEFAULT_USER /nix

# Download script
RUN curl -L https://nixos.org/nix/install > /home/$DEFAULT_USER/nix.sh
RUN chmod +x /home/$DEFAULT_USER/nix.sh
RUN chown $DEFAULT_USER:$DEFAULT_USER /home/$DEFAULT_USER/nix.sh


# Installation is user only
USER $DEFAULT_USER
ENV USER=$DEFAULT_USER
WORKDIR /home/$DEFAULT_USER

# Run install script and clean it
RUN mkdir .config/nix/ -p 
RUN echo "sandbox = false" >> .config/nix/nix.conf
RUN echo "experimental-features = nix-command flakes" >> .config/nix/nix.conf


RUN ./nix.sh --no-daemon
RUN rm nix.sh

# Nix environment variables persistence
ENV NIX_PATH=${NIX_PATH:+$NIX_PATH:}/home/$DEFAULT_USER/.nix-defexpr/channels
ENV NIX_PROFILES="/nix/var/nix/profiles/default /home/$DEFAULT_USER/.nix-profile"
ENV NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV PATH=/home/$DEFAULT_USER/.nix-profile/bin:$PATH
RUN echo $(env | sed -e 's/^/export /' | sed -e "s/\/.*$/\'&\'/") > .profile

# TODO Install my home-manager configuration
RUN git clone $NIX_FLAKE_REPO
RUN ./nixpine/setup.sh

# Garbage collect before finishing
RUN nix-collect-garbage
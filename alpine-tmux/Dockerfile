# Developer: GeekSaga <geeksaga@gmail.com>
#
# GitHub: https://github.com/geeksaga

FROM alpine:latest

LABEL com.geeksaga.maintainer="GeekSaga" \
      com.geeksaga.version="0.1.0"

ENV \
    UID="1000" \
    GID="1000" \
    UNAME="tmux" \
    GNAME="tmux" \
    SHELL="/bin/zsh" \
    WORKSPACE="/data" \
    NVIM_CONFIG="/home/${UNAME}/.config/nvim" \
    PATH="/home/neovim/.local/bin:${PATH}"

ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-${UNAME}}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

# install dependencies
# https://github.com/Yelp/dumb-init
RUN apk add --no-cache \
  bash \
  zsh \
  neovim \
  neovim-doc \
  git \
  curl \
  python3-dev \
  clang \
  go \
  nodejs \
  npm \
  yarn \  
  ctags \
  unzip \
  tmux \
  xclip \
# dumb-init \
  && rm -rf /var/cache/apk/*
  #&& apk del build-dependencies

WORKDIR /tmp

# adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \

RUN addgroup "${GNAME}" && \
    adduser -h ${SERVICE_HOME} -D -G "${GNAME}" -g "" -s "${SHELL}" "${SERVICE_USER}" && \
    echo "${SERVICE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chgrp -R users .

USER    ${SERVICE_USER}

# install tpm
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install dotfiles
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/geeksaga/dotfiles/master/install.sh)"

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install all plugins
RUN nvim +PlugInstall +qa 

ENV TERM xterm

WORKDIR ${WORKSPACE}
# VOLUME  ${SERVICE_HOME}

CMD /usr/bin/nvim 

# ENTRYPOINT [ "/usr/bin/dumb-init", "--", "nvim" ]

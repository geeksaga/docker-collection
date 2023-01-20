# Developer: GeekSaga <geeksaga@gmail.com>
#
# GitHub: https://github.com/geeksaga

FROM alpine:latest

LABEL com.geeksaga.maintainer="GeekSaga" \
      com.geeksaga.version="0.1.1"

ENV \
    UID="1000" \
    GID="1000" \
    UNAME="neovim" \
    GNAME="neovim" \
    SHELL="/bin/zsh" \
    WORKSPACE="/data" \
    NVIM_CONFIG="/home/neovim/.config/nvim" \
    PATH="/home/neovim/.local/bin:${PATH}"

ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-${UNAME}}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

WORKDIR /tmp

# install dependencies
# https://github.com/Yelp/dumb-init
RUN apk add --no-cache --update \
  bash \
  zsh \
  neovim \
  neovim-doc \
  git \
  curl \
  wget \
  python3-dev \
  clang \
  musl-dev \
  go \
  nodejs \
  npm \
  yarn \  
# ctags \
  unzip \
# dumb-init \
  util-linux \
  stow \
  ninja \
  g++ \
  && rm -rf /var/cache/apk/*
  #&& apk del build-dependencies

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \

RUN addgroup "${GNAME}" && \
    adduser -h ${SERVICE_HOME} -D -G "${GNAME}" -g "" -s "${SHELL}" "${SERVICE_USER}" && \
    echo "${SERVICE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chgrp -R users .

USER    ${SERVICE_USER}

# install dotfiles
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/geeksaga/dotfiles/master/install.sh)"

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#COPY --chown="${UNAME}":"${GNAME}" pep8 /home/"${UNAME}"/.config/pep8

# install all plugins
RUN nvim +PlugInstall +qa 

ENV TERM xterm

WORKDIR ${WORKSPACE}
# VOLUME  ${SERVICE_HOME}

CMD /usr/bin/nvim 

# ENTRYPOINT [ "/usr/bin/dumb-init", "--", "nvim" ]

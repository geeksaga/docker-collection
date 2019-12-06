FROM alpine:latest as builder

LABEL maintainer "GeekSaga <geeksaga@gmail.com>"

ENV \
    UID="1000" \
    GID="1000" \
    UNAME="neovim" \
    GNAME="neovim" \
    SHELL="/bin/zsh" \
    WORKSPACE="/data" \
	  NVIM_CONFIG="/home/neovim/.config/nvim" \
    PATH="/home/neovim/.local/bin:${PATH}"

# Install dependencies
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
  && rm -rf /var/cache/apk/*
  #&& apk del build-dependencies

WORKDIR /tmp

RUN addgroup "${GNAME}"
RUN adduser -D -G "${GNAME}" -g "" -s "${SHELL}" "${UNAME}"
RUN echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chgrp -R users .

USER "${UNAME}"

#install dotfiles
#RUN git -C "/home/${UNAME}" clone --depth 1 https://github.com/geeksaga/dotfiles.git ~/#.dotfiles \
# && cd ~/.dotfiles/ \
# && ./install.sh

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/geeksaga/dotfiles/master/install.sh)"

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy init.vim into container
#COPY --chown="${UNAME}":"${GNAME}" init.vim /home/"${UNAME}"/.config/nvim/init.vim
#COPY --chown="${UNAME}":"${GNAME}" pep8 /home/"${UNAME}"/.config/pep8

# install all plugins
RUN nvim +PlugInstall +qa 

ENV TERM xterm

WORKDIR ${WORKSPACE}

CMD /usr/bin/nvim 

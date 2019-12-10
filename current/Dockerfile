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

#COPY sshd_config /etc/ssh/sshd_config

ADD entrypoint.sh /usr/local/bin

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
  libseccomp \
#  openrc \
  openssh \
# dumb-init \
  && pip3 install powerline-status \
  && rm -rf /tmp/* /var/cache/apk/*
  #&& apk del build-dependencies

WORKDIR /tmp

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

# adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \

RUN addgroup "${GNAME}" && \
    adduser -h ${SERVICE_HOME} -D -G "${GNAME}" -g "" -s "${SHELL}" "${SERVICE_USER}" && \
    echo "${SERVICE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chgrp -R users .

#RUN rc-update add sshd \
#    && rc-status \
#    && touch /run/openrc/softlevel \
#    && /etc/init.d/sshd start > /dev/null 2>&1 \
#    && /etc/init.d/sshd stop > /dev/null 2>&1

#USER    ${SERVICE_USER}

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

#              ssh   mosh
#EXPOSE 80 8080 62222 60001/udp

ENV TERM xterm

WORKDIR ${WORKSPACE}
# VOLUME  ${SERVICE_HOME}

#COPY start.bash /usr/local/bin/start.bash
#ENTRYPOINT ["bash", "/usr/local/bin/start.bash"]

EXPOSE 22
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

#CMD /usr/bin/nvim 

# ENTRYPOINT [ "/usr/bin/dumb-init", "--", "nvim" ]

ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      firefox \
      neovim \
      tmux \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      google-chrome-beta \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-add-repository ppa:fish-shell/release-3 \
    && apt-get update \
    && apt-get install -y \
      git \
      fish \
      fzf \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/tools && cd /tmp/tools \
    && curl -LO https://github.com/motemen/ghq/releases/download/v0.12.6/ghq_linux_amd64.zip \
    && unzip *.zip \
    && sudo mv ghq_*/ghq /usr/local/bin/ \
    && cd /tmp && rm -rf /tmp/tools

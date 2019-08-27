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

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable" \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      docker-ce \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-add-repository ppa:fish-shell/release-3 \
    && apt-get update \
    && apt-get install -y \
      git \
      fish \
      fzf \
      psmisc \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/tools && cd /tmp/tools \
    && curl -LO https://github.com/motemen/ghq/releases/download/v0.12.6/ghq_linux_amd64.zip \
    && unzip *.zip \
    && sudo mv ghq_*/ghq /usr/local/bin/ \
    && cd /tmp && rm -rf /tmp/tools

RUN apt-get update \
    && apt-get install -y \
      python-pip \
    && pip install powerline-status --system \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y \
      xsel \
      tig \
      openjdk-8-jdk openjdk-11-jdk default-jdk \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y \
      code \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/ide && cd /tmp/ide \
    && curl -LO https://download.jetbrains.com/idea/ideaIC-2019.2.1.tar.gz \
    && tar -xzf *.tar.gz -C /opt \
    && cd /tmp && rm -rf /tmp/ide

ADD xrdp_keyboard.ini /etc/xrdp/

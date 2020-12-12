# centos8-gcc10-llvm11-env
基于centos8打造的gcc10.2.0,llvm11.0.0 以及配套工具链的docker开发镜像

# todo
1. 整理 Dockerfile,把 yum install 合并到一块
2. 使用 docker 多阶段编译,只拷贝有用的内容,将镜像大小从21G减到5G左右
3. 权限问题如何处理?现在每次start.sh都要 chmod 太费时间了

# some bashrc
alias ls='ls --color'
alias vi='nvim'
alias py3='python3'
alias vb='vi ~/.bashrc'
alias sb='source ~/.bashrc'
alias sd="svn diff -x \"-w --ignore-eol-style\""
alias gdb='gdb -q'
alias sdi='sudo docker images'
alias sdp='sudo docker ps'


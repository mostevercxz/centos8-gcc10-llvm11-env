FROM centos:8
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup", "/data/sbin"]
RUN cd /etc/yum.repos.d && rm -rf *
COPY ./yum.repos.d/ /etc/yum.repos.d/

RUN yum install -y make 
RUN yum install -y make cmake3 git 
RUN rpm -ivh https://packagecloud.io/github/git-lfs/packages/el/8/git-lfs-2.12.1-1.el8.x86_64.rpm/download

RUN dnf -y --enablerepo=PowerTools install ninja-build
RUN yum install -y yum-utils 
RUN yum-config-manager  -y --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
RUN  yum install -y ripgrep
RUN yum-config-manager -y --disable copr:copr.fedorainfracloud.org:carlwgeorge:ripgrep
RUN rpm --import https://package.perforce.com/perforce.pubkey
COPY perforce.repo /etc/yum.repos.d/
RUN yum install -y helix-p4d
RUN yum install -y wget
COPY ./pbzip2 /usr/bin
COPY ./pigz /usr/bin

RUN wget https://ftp.gnu.org/gnu/binutils/binutils-2.35.1.tar.bz2
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
RUN yum install -y bzip2
RUN tar -xf binutils-2.35.1.tar.bz2 
RUN yum install -y autoconf automake unzip zip gcc gcc-c++
RUN yum install -y diffutils file
RUN  cd binutils-2.35.1 && mkdir my_build && cd my_build && \
../configure --enable-gold --enable-ld --prefix=/usr &&  make -j45 MAKEINFO=true &&  make install MAKEINFO=true
RUN wget https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz
RUN wget https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2
RUN wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2
RUN wget https://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.0.3.tar.gz
RUN wget https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-3.1.4.tar.bz2
RUN tar -xf gcc-10.2.0.tar.gz
RUN tar -xf cloog-0.18.1.tar.gz -C gcc-10.2.0
RUN tar -xf gmp-6.1.0.tar.bz2 -C gcc-10.2.0
RUN tar -xf isl-0.18.tar.bz2 -C gcc-10.2.0
RUN tar -xf mpc-1.0.3.tar.gz -C gcc-10.2.0
RUN tar -xf mpfr-3.1.4.tar.bz2 -C gcc-10.2.0
RUN cd gcc-10.2.0 && mv cloog-0.18.1 cloog && mv gmp-6.1.0 gmp && mv isl-0.18 isl && mv mpc-1.0.3 mpc && mv mpfr-3.1.4 mpfr
RUN dnf -y --enablerepo=PowerTools install texinfo
RUN cd gcc-10.2.0 && mkdir my_build && cd my_build && ../configure -prefix=/usr --enable-languages=c,c++ --disable-multilib && make -j45 && make install
RUN yum install -y zlib-devel  bzip2-devel xz-devel lrzsz
RUN wget https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.gz
RUN tar -xf expat-2.2.10.tar.gz && cd expat-2.2.10 && mkdir my_build && cd my_build && \
../configure --enable-shared --enable-static --without-docbook --without-examples --without-tests && make -j45 && make install
RUN wget https://ftp.pcre.org/pub/pcre/pcre2-10.36.tar.gz
RUN tar -xf pcre2-10.36.tar.gz && cd pcre2-10.36 && mkdir my_build && cd my_build && \
../configure --enable-shared --enable-static --enable-jit --enable-fuzz-support && make -j45 && make install
RUN wget https://www.openssl.org/source/openssl-1.1.1h.tar.gz
RUN tar -xf openssl-1.1.1h.tar.gz && cd openssl-1.1.1h && mkdir my_build && cd my_build && ../config && \
make -j45 && make install_sw && make install_ssldirs
# ncurses,文字交互界面,感觉暂时用不到源码安装,改为系统安装
# readline,直接安装系统开发包
# libedit,直接装系统开发包
# libevent,
RUN yum install -y ncurses-devel readline-devel
RUN dnf -y --enablerepo=PowerTools install libedit-devel
RUN yum install -y libevent-devel
# libssh2在centos8下有问题,原作者不愿意改进\建议用 libssh 替代
RUN yum install -y libssh-devel libcurl-devel sqlite-devel libffi-devel
RUN wget http://prdownloads.sourceforge.net/swig/swig-4.0.2.tar.gz
RUN tar -xf swig-4.0.2.tar.gz && cd swig-4.0.2 && ./autogen.sh && ./configure --without-pcre --without-alllang && make -j45 && make install

# zsh,找不到tty报错,改为直接用 yum安装
#RUN wget https://github.com/zsh-users/zsh/archive/zsh-5.8.tar.gz
#RUN tar -xf zsh-5.8.tar.gz && cd zsh-zsh-5.8 && ./Util/preconfig  && mkdir my_build && cd my_build && ../configure --disable-gdbm --enable-pcre && make -j45 && make install
RUN yum install -y zsh
# git,不需要源码安装,安装过了(with-expat待考究)
#RUN wget https://github.com/git/git/archive/v2.29.2.tar.gz
#RUN tar -xf v2.29.2.tar.gz && cd git-2.29.2 && make configure && ./configure --with-openssl --with-curl --with-expat && make -j45 && make install
RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz
RUN tar -xf Python-3.9.0.tar.xz
RUN cd Python-3.9.0 && mkdir my_build && cd my_build && ../configure --enable-shared && make -j45 && make install
RUN echo "/usr/local/lib" >> /etc/ld.so.conf.d/python3.conf && ldconfig
RUN ln -s  /usr/local/bin/python3.9 /usr/bin/python
# 这些python包应该装在用户目录下,而非污染系统python
# todo,创建用户,添加python包
#COPY ./requirements.txt /root
#RUN pip3 install --user -r requirements.txt
RUN wget https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.xz
RUN tar -xf gdb-10.1.tar.xz
RUN cd gdb-10.1 && mkdir my_build && cd my_build && ../configure --with-python=/usr/local/bin/python3.9 && make -j45  MAKEINFO=true  && make install MAKEINFO=true
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.1/cmake-3.19.1-Linux-x86_64.tar.gz
RUN tar -xf cmake-3.19.1-Linux-x86_64.tar.gz && cp -rf cmake-3.19.1-Linux-x86_64/* /usr/
# 重头戏,llvm
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/llvm-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/lld-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/lldb-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-tools-extra-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/compiler-rt-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/libcxx-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/libcxxabi-11.0.0.src.tar.xz
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/libunwind-11.0.0.src.tar.xz
RUN tar -xf llvm-11.0.0.src.tar.xz
RUN tar -xf clang-11.0.0.src.tar.xz -C llvm-11.0.0.src/tools
RUN tar -xf lld-11.0.0.src.tar.xz -C llvm-11.0.0.src/tools
RUN tar -xf lldb-11.0.0.src.tar.xz -C llvm-11.0.0.src/tools
RUN cd llvm-11.0.0.src/tools && mv clang-11.0.0.src clang && mv lld-11.0.0.src lld   && mv lldb-11.0.0.src lldb
RUN tar -xf clang-tools-extra-11.0.0.src.tar.xz -C llvm-11.0.0.src/tools/clang/tools
RUN cd llvm-11.0.0.src/tools/clang/tools && mv clang-tools-extra-11.0.0.src extra
RUN tar -xf compiler-rt-11.0.0.src.tar.xz -C llvm-11.0.0.src/projects
RUN tar -xf libcxx-11.0.0.src.tar.xz -C llvm-11.0.0.src/projects
RUN tar -xf libcxxabi-11.0.0.src.tar.xz -C llvm-11.0.0.src/projects
RUN tar -xf libunwind-11.0.0.src.tar.xz -C llvm-11.0.0.src/projects
RUN cd llvm-11.0.0.src/projects && mv compiler-rt-11.0.0.src compiler-rt && mv libcxx-11.0.0.src libcxx  && mv libcxxabi-11.0.0.src libcxxabi   && mv libunwind-11.0.0.src libunwind
#RUN cd llvm-11.0.0.src && mkdir my_build && cd my_build  && \
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.5/cmake-3.18.5-Linux-x86_64.tar.gz
RUN tar -xf cmake-3.18.5-Linux-x86_64.tar.gz && cp -rf cmake-3.18.5-Linux-x86_64/* /usr
RUN cd llvm-11.0.0.src && mkdir my_build && cd my_build  && \
cmake -G "Ninja" .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/ -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_ENABLE_Z3_SOLVER=OFF -DLLVM_BUILD_EXAMPLES=OFF -DLLVM_BUILD_TESTS=OFF -DLLVM_BUILD_DOCS=OFF
RUN  cd llvm-11.0.0.src/my_build && ninja 
RUN  cd llvm-11.0.0.src/my_build && ninja install
# gn 这个编译程序暂时没用,不安装了
# https://gn.googlesource.com/gn
RUN yum install -y emacs tmux
# todo,把gdb,python也安装到 /usr/ 目录中
RUN rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm
RUN dnf -y install dotnet-sdk-3.1
#RUN wget  https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#RUN mv nvim.appimage /usr/bin/nvim && chmod +x /usr/bin/nvim && ln -s  /usr/bin/nvim /usr/bin/vim
# todo, neovim 改成从源码编译
RUN yum install -y epel-release
RUN yum install -y neovim

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
EXPOSE 22 
LABEL Maintainer="Xiaoxin <xiaoxin@papergames.net>"
LABEL Description="CentOS 8 x6 dev image"
LABEL VERSION="2"
RUN yum install -y libss openssh openssh-server openssh-clients

# 收尾工作,删掉临时目录
RUN rm -rf gcc-10.2.0 Python-3.9.0 binutils-2.35.1 cmake-3.18.5-Linux-x86_64 gdb-10.1 llvm-11.0.0.src openssl-1.1.1h
ADD start.sh /start.sh
RUN chmod +x /start.sh /tini
RUN echo 'root:Ranxun2020' | chpasswd
RUN useradd -m dev && echo "dev:123456" | chpasswd
RUN echo "dev ALL=(ALL) ALL" >> /etc/sudoers
ENTRYPOINT ["/tini", "-g", "--"]
CMD /start.sh

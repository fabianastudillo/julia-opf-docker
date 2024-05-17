FROM julia:latest
LABEL MAINTAINER="Aurelio Amerio, Fabian Astudillo Salinas <fabian.astudillos@ucuenca.edu.ec>"

ARG password
ARG dbpassword
########################################################
# Essential packages for remote debugging and login in
########################################################

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    apt-utils gcc g++ openssh-server cmake build-essential gdb \
    gdbserver rsync nano locales
RUN apt-get install -y bzip2 wget gnupg dirmngr apt-transport-https \
	ca-certificates openssh-server tmux && \
    apt-get clean

#RUN julia conda update -n base -c conda-forge conda

#setup ssh
RUN mkdir /var/run/sshd && \
    echo 'root:${password}' |chpasswd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh

#remove leftovers
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; exit 0

# Expose 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777

# add user for debugging
RUN useradd -ms /bin/bash debugger
RUN echo 'debugger:${dbpassword}' | chpasswd

########################################################
# Add custom packages and development environment here
########################################################

########################################################

CMD ["/usr/sbin/sshd", "-D"]

#add support for English and Spanish
COPY locale.gen /etc/locale.gen
RUN locale-gen


#RUN echo $HOME

RUN mkdir /root/src

RUN mkdir /root/data

WORKDIR /root/

# https://github.com/JuliaLang/PackageCompiler.jl/issues/825
# https://julialang.github.io/PackageCompiler.jl/dev/sysimages.html
COPY opf_sysimage.jl opf_sysimage.jl 
RUN julia -p `nproc` opf_sysimage.jl 

#COPY install.jl install.jl 
#RUN julia install.jl

#COPY aliases.sh /etc/profile.d/

#ENV ENV="/etc/profile"

RUN echo "alias julia=\"julia -J/root/opf-sysimage.so\"" >> ~/.bashrc

#COPY createimage.jl createimage.jl

#RUN julia --startup-file=no --output-o=sys.o -J"/usr/local/julia/lib/julia/sys.so" opf-sysimage.jl
# JULIA_DEBUG=all 

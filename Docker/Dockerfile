FROM ubuntu

MAINTAINER Keishi <ishihara@aisl.cs.tut.ac.jp>

RUN echo "now building..."
RUN apt update && \
    apt install -y less vim && \
    apt install -y git make git aptitude

RUN aptitude install ruby && \
    gem install rubygems-update && \
    gem install tmuxinator

WORKDIR /root/
ARG GITHUB_USER
ARG GITHUB_TOKEN

RUN touch /root/.netrc \
    echo machine github.com >> /root/.netrc \
    echo login $GITHUB_USER >> /root/.netrc \
    echo passowrd $GITHUB_TOKEN >> /root/.netrc \
    pip install -r requirements.txt \
RUN git config --global http.sslVerify false && git clone https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git
# --> user名とパスワードが必要?
RUN rm /root/.netrc

COPY startup.sh /startup.sh
RUN chmod 744 /startup.sh
CMD ["/startup.sh"]
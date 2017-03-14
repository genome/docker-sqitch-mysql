#########################################################
# Docker for Running Sqitch with MySQL on Trusty at MGI #
# http://sqitch.org/                                    #
# https://www.mysql.com/                                #
#########################################################

# Based on...
FROM ubuntu:trusty

# File Author / Maintainer
MAINTAINER Eddie Belter <ebelter@wustl.edu>

# Image & Squitch Deps
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	build-essential \
	curl \
	gcc \
	perl \
	perl-modules \
	libnss-sss \
	make \
	mysql-client-5.5 \
	sqlite3 && \
	apt-get clean

# Install sqitch perl deps
RUN cpan HTML::Entities Test::MockObject Test::NoWarnings Test::Exception IPC::System::Simple Moo
# Install sqitch
RUN cpan App:Sqitch

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	ca-certificates \
	git && \
	apt-get clean

# Use sqitch wrapper to setup ENV and allow running a bash session
RUN mkdir /opt/bin/ && \
	cd /tmp/ && \
	git clone https://github.com/genome/docker-sqitch-mysql.git && \
	cd docker-sqitch-mysql/ && \
	cp sqitch /opt/bin/ && \
	cd / && \
	rm -rf /tmp/docker-sqitch-mysql
RUN chmod 777 /opt/bin/sqitch

# Set timezone
RUN echo "America/Chicago" > /tmp/timezone && \
	mv -f /tmp/timezone /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

# Entrypoint is sqitch wrapper script
ENTRYPOINT ["/opt/bin/sqitch"]


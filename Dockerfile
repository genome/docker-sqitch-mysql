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
	ca-certificates \
	cpanminus \
	curl \
	gcc \
	git \
	perl \
	perl-modules \
	libnss-sss \
	make \
	mysql-client-5.5 \
	sqlite3 && \
	apt-get clean

# Install sqitch & deps
RUN PERL_MM_USE_DEFAULT=1 cpan App::Sqitch
RUN PERL_MM_USE_DEFAULT=1 cpan DBD::SQLite

# Set timezone
RUN TZ="America/Chicago"

#Set LANG for perl
ENV LANG C

# SQITCH!
ENTRYPOINT ["sqitch"]

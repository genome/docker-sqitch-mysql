#########################################################
# Docker for Running Sqitch with MySQL on Trusty at MGI #
# http://sqitch.org/                                    #
# https://www.mysql.com/                                #
#########################################################

# Based on...
FROM ubuntu:trusty

# File Author / Maintainer
MAINTAINER Eddie Belter <ebelter@wustl.edu>

# Image Deps
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	build-essential \
	curl \
	gcc \
	perl \
	perl-modules \
	libnss-sss \
	make

# Install sqitch
RUN cpan HTML::Entities Test::MockObject Test::NoWarnings Test::Exception Moo App:Sqitch

# Install MySQL and SQLite
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	mysql-client-5.5=5.5.53-0ubuntu0.14.04.1 \
	sqlite3 && \
	apt-get clean


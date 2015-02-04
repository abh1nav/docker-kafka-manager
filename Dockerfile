FROM devdb/kafka

MAINTAINER Abhinav Ajgaonkar <abhinav316@gmail.com>

RUN \
	cd /opt; \
	wget https://dl.bintray.com/sbt/debian/sbt-0.13.7.deb; \
	dpkg -i sbt-0.13.7.deb; \
	mkdir -p /etc/service/kafka-manager; \
	sudo apt-get update; \
	sudo apt-get install -y -qq unzip;

ADD . /src

RUN	\
	cd /src; \
	mv run /etc/service/kafka-manager; \
	sbt clean dist; \
	cd target/universal; \
	unzip kafka-manager-1.0-SNAPSHOT.zip; \
	mv kafka-manager-1.0-SNAPSHOT /opt/kafka-manager; \
	cd /opt; \
	rm -Rf /src /root/.sbt /root/.ivy2 /root/.m2

EXPOSE 2181 9000 9092

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*